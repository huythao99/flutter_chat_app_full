import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ConversationsService } from 'src/conversations/conversations.service';
import { EVENT } from 'src/events/constants';
import { EventsGateway } from 'src/events/events.gateway';
import { Message, MessageDocument } from 'src/schema/message.schema';
import { CreateMessageDto } from './dto/create-message.dto';

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
      console.log(message);
      const messagePayload = {
        sender: message.sender,
        conversation: res.toObject()._id,
        message: message.message,
        image: message.image || '',
      };
      const newMessage = await this.messageModel.create(messagePayload);
      this.socket.emitEvent(EVENT.NEW_MESSAGE, { ...newMessage.toObject() });
      this.socket.emitEvent(EVENT.CREATE_CONVERSATION, { ...res.toObject() });
      return {
        message: { ...newMessage.toObject() },
        conversation: { ...res.toObject() },
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
      this.socket.emitEvent(EVENT.NEW_MESSAGE, { ...newMessage.toObject() });
      this.socket.emitEvent(EVENT.UPDATE_CONVERSATION, { ...res?.toObject() });

      return {
        message: {
          ...newMessage.toObject(),
        },
      };
    }
  }
}
