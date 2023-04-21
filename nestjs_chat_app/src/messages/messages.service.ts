import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { PER_PAGE } from 'src/constants';
import { ConversationsService } from 'src/conversations/conversations.service';
import { EVENT } from 'src/events/constants';
import { EventsGateway } from 'src/events/events.gateway';
import { Message, MessageDocument } from 'src/schema/message.schema';
import { CreateMessageDto } from './dto/create-message.dto';
import { GetMessageDto } from './dto/get-message.dto';

@Injectable()
export class MessagesService {
  constructor(
    @InjectModel(Message.name)
    private messageModel: Model<MessageDocument>,
    private conversationService: ConversationsService,
    private socket: EventsGateway,
  ) {}

  async createMessage(message: CreateMessageDto, email: string) {
    if (message.conversation === '') {
      const conversationPayload = {
        sender: message.sender,
        receiver: message.receiver,
        message: message.image ? 'Đã gửi một ảnh' : message.message,
      };
      const res = await this.conversationService.createConversation(
        conversationPayload,
        email,
      );
      const messagePayload = {
        sender: message.sender,
        conversation: res.toObject()._id,
        message: message.message,
        image: message.image || '',
      };
      const newMessage = await this.messageModel.create(messagePayload);
      const conversation = await this.conversationService.searchById(
        res._id.toString(),
      );
      this.socket.emitEventToRoom(
        EVENT.NEW_MESSAGE,
        res.toObject()._id.toString(),
        {
          ...newMessage.toObject(),
          conversation: {
            ...conversation?.toObject(),
          },
        },
      );
      this.socket.emitEvent(EVENT.CREATE_CONVERSATION, { ...res.toObject() });
      return {
        message: {
          ...newMessage.toObject(),
          conversation: { ...conversation?.toObject() },
        },
      };
    } else {
      const messagePayload = {
        sender: message.sender,
        conversation: message.conversation,
        message: message.message,
        image: message.image,
      };
      const res = await this.conversationService.updateConversation(
        {
          conversation_id: message.conversation,
          sender: message.sender,
          message: message.image ? 'Đã gửi một ảnh' : message.message,
        },
        email,
      );
      const newMessage = await this.messageModel.create(messagePayload);

      const conversation = await this.conversationService.searchById(
        message.conversation,
      );

      this.socket.emitEventToRoom(EVENT.NEW_MESSAGE, message.conversation, {
        ...newMessage.toObject(),
        conversation: {
          ...conversation?.toObject(),
        },
      });
      this.socket.emitEvent(EVENT.UPDATE_CONVERSATION, {
        ...res?.toObject(),
      });
      return {
        message: {
          ...newMessage.toObject(),
          conversation: {
            ...conversation?.toObject(),
          },
        },
      };
    }
  }

  async getMessages(params: GetMessageDto) {
    if (params.conversationID === '') {
      const res = await this.messageModel
        .find()
        .populate({
          path: 'conversation',
          match: {
            $and: [
              {
                receiver: { $in: params.receiver },
              },
              {
                receiver: {
                  $size: params.receiver.length,
                },
              },
            ],
          },
        })
        .skip(params.skip)
        .limit(PER_PAGE)
        .sort({ createdAt: 'desc' });
      const total = await this.messageModel.countDocuments().populate({
        path: 'conversation',
        match: {
          $and: [
            {
              receiver: { $in: params.receiver },
            },
            {
              receiver: {
                $size: params.receiver.length,
              },
            },
          ],
        },
      });
      return {
        messages: [...res],
        total,
        conversation: res[0]?.toObject()?.conversation,
      };
    } else {
      const res = await this.messageModel
        .find({ conversation: params.conversationID })
        .skip(params.skip)
        .limit(PER_PAGE)
        .sort({ createdAt: 'desc' });
      const total = await this.messageModel.countDocuments({
        conversation: params.conversationID,
      });

      return {
        messages: [...res],
        total,
        conversation: res[0]?.toObject()?.conversation,
      };
    }
  }
}
