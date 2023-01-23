import { Module } from '@nestjs/common';
import { ConversationsController } from './conversations.controller';
import { Conversations } from './conversations';
import { ConversationsService } from './conversations.service';
import { MongooseModule } from '@nestjs/mongoose';
import {
  Conversation,
  ConversationSchema,
} from 'src/schema/conversation.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Conversation.name, schema: ConversationSchema },
    ]),
  ],
  controllers: [ConversationsController],
  providers: [Conversations, ConversationsService],
})
export class ConversationsModule {}
