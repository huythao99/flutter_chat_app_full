import {
  Controller,
  Get,
  HttpException,
  HttpStatus,
  Query,
} from '@nestjs/common';
import { SearchUserDto } from './dto/search-user.dto';
import { UserService } from './user.service';

@Controller()
export class UserController {
  constructor(private readonly appService: UserService) {}

  @Get('user')
  async search(@Query() searchParams: SearchUserDto) {
    try {
      return this.appService.search(searchParams);
    } catch (error) {
      throw new HttpException(
        new Error('Something went wrong'),
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
