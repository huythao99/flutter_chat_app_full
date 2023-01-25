import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ConversationsModule } from 'src/conversations/conversations.module';
import { EventsGateway } from 'src/events/events.gateway';
import { Message, MessageSchema } from 'src/schema/message.schema';
import { MessagesController } from './messages.controller';
import { MessagesService } from './messages.service';

@Module({
  controllers: [MessagesController],
  providers: [MessagesService, EventsGateway],
  imports: [
    MongooseModule.forFeature([{ name: Message.name, schema: MessageSchema }]),
    ConversationsModule,
  ],
})
export class MessagesModule {}
