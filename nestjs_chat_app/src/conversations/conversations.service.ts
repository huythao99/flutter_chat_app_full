import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { PER_PAGE } from 'src/constants';
import {
  Conversation,
  ConversationDocument,
} from 'src/schema/conversation.schema';
import { CreateConversationDto } from './dto/create-conversation.dto';
import { SearchConversationDto } from './dto/search-conversation.dto';
import { UpdateConversationDto } from './dto/update-conversation.dto';

@Injectable()
export class ConversationsService {
  constructor(
    @InjectModel(Conversation.name)
    private conversationModel: Model<ConversationDocument>,
  ) {}

  async search(params: SearchConversationDto, email: string) {
    const res = await this.conversationModel
      .find()
      .populate({
        path: 'receiver',
        match: {
          email: { $in: [email, new RegExp(params.keyword, 'i')] },
        },
        select: '-password',
      })
      .skip(params.skip)
      .limit(PER_PAGE)
      .sort('asc')
      .exec();
    const total = await this.conversationModel
      .countDocuments({
        email: email,
      })
      .populate({
        path: 'receiver',
        match: {
          email: { $in: [email, new RegExp(params.keyword, 'i')] },
        },
        select: '-password',
      })
      .exec();

    return {
      total,
      conversations: [...res],
    };
  }

  async createConversation(conversation: CreateConversationDto, email: string) {
    return (await this.conversationModel.create(conversation)).populate({
      path: 'receiver',
      match: {
        email: { $in: [email] },
      },
      select: '-password',
    });
  }

  async updateConversation(params: UpdateConversationDto, email: string) {
    await this.conversationModel.findByIdAndUpdate(params.conversation_id, {
      sender: params.sender,
      message: params.message,
    });
    return this.conversationModel.findById(params.conversation_id).populate({
      path: 'receiver',
      match: {
        email: { $in: [email] },
      },
      select: '-password',
    });
  }

  async searchById(id: string) {
    return this.conversationModel.findById(id);
  }
}
