import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [
    MongooseModule.forRoot(
      'mongodb+srv://username:username@flutterchatappcluster.qxyhcpf.mongodb.net/?retryWrites=true&w=majority',
    ),
    AuthModule,
  ],
  exports: [AuthModule],
})
export class AppModule {}
