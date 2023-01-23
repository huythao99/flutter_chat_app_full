import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { ConversationsModule } from './conversations/conversations.module';
import { MessagesModule } from './messages/messages.module';
import { JwtModule } from '@nestjs/jwt';

@Module({
  imports: [
    MongooseModule.forRoot(
      'mongodb+srv://username:username@flutterchatappcluster.qxyhcpf.mongodb.net/?retryWrites=true&w=majority',
    ),
    AuthModule,
    UserModule,
    ConversationsModule,
    MessagesModule,
    JwtModule,
  ],
  exports: [AuthModule, UserModule],
})
export class AppModule {}
