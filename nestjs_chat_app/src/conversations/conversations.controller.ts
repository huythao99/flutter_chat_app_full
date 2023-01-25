import {
  Controller,
  Get,
  HttpException,
  HttpStatus,
  Query,
  Request,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { ConversationsService } from './conversations.service';
import { SearchConversationDto } from './dto/search-conversation.dto';

@Controller()
export class ConversationsController {
  constructor(private readonly conversationService: ConversationsService) {}

  @UseGuards(JwtAuthGuard)
  @Get('conversation')
  async getConversation(
    @Query() searchParams: SearchConversationDto,
    @Request() req: any,
  ) {
    try {
      return this.conversationService.search(searchParams, req.user.email);
    } catch (error) {
      throw new HttpException(
        'Something went wrong',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
