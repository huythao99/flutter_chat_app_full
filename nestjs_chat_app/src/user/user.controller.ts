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
import { SearchUserDto } from './dto/search-user.dto';
import { UserService } from './user.service';

@Controller()
export class UserController {
  constructor(private readonly appService: UserService) {}

  @UseGuards(JwtAuthGuard)
  @Get('user')
  async search(@Query() searchParams: SearchUserDto, @Request() req: any) {
    try {
      return this.appService.search(searchParams, req.user.email);
    } catch (error) {
      throw new HttpException(
        new Error('Something went wrong'),
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
