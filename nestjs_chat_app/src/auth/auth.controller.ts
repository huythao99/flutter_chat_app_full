import {
  Controller,
  Get,
  Post,
  Body,
  HttpException,
  HttpStatus,
  UseInterceptors,
  UploadedFile,
  ParseFilePipe,
  MaxFileSizeValidator,
  FileTypeValidator,
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
  @UseInterceptors(
    FileInterceptor('avatar', {
      dest: '123',
    }),
  )
  async register(
    @UploadedFile(
      new ParseFilePipe({
        fileIsRequired: true,
        validators: [
          // ... Set of file validator instances here
          new MaxFileSizeValidator({ maxSize: 100000 }),
          new FileTypeValidator({
            fileType: 'image/png',
          }),
        ],
        errorHttpStatusCode: HttpStatus.BAD_REQUEST,
      }),
    )
    avatar: Express.Multer.File,
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
