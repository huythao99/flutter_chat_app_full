import {
  Body,
  Controller,
  Get,
  HttpException,
  HttpStatus,
  Post,
  Query,
  Request,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { CreateMessageDto } from './dto/create-message.dto';
import { GetMessageDto } from './dto/get-message.dto';
import { MessagesService } from './messages.service';

@Controller()
export class MessagesController {
  constructor(private readonly messageService: MessagesService) {}

  @UseGuards(JwtAuthGuard)
  @Post('message')
  async createMessage(
    @Body() messageParams: CreateMessageDto,
    @Request() req: any,
  ) {
    try {
      return this.messageService.createMessage(messageParams, req.user.email);
    } catch (error) {
      throw new HttpException(
        'Something went wrong',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @UseGuards(JwtAuthGuard)
  @Get('message')
  async getMessages(@Query() params: GetMessageDto) {
    try {
      return this.messageService.getMessages(params);
    } catch (error) {
      throw new HttpException(
        'Something went wrong',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
