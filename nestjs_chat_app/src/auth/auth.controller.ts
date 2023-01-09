import {
  Controller,
  Get,
  Post,
  Body,
  HttpException,
  HttpStatus,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { AuthService } from './auth.service';
import { CreateUserDto } from './dto/create-user.dto';
import { LoginUserDto } from './dto/login-user.dto';

@Controller()
export class AuthController {
  constructor(private readonly appService: AuthService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Post('auth/login')
  async login(@Body() loginParams: LoginUserDto) {
    try {
      return this.appService.login(loginParams);
    } catch (error) {
      throw new HttpException(
        new Error('Something went wrong'),
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Post('auth/signup')
  @UseInterceptors(FileInterceptor('avatar'))
  async register(
    @UploadedFile() avatar: Express.Multer.File,
    @Body() signupParams: CreateUserDto,
  ) {
    try {
      return this.appService.register(signupParams, avatar);
    } catch (error) {
      throw new HttpException(
        new Error('Something went wrong'),
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
