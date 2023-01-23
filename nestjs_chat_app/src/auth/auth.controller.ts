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
  UseGuards,
  Request,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { AuthService } from './auth.service';
import { CreateUserDto } from './dto/create-user.dto';
import { LocalAuthGuard } from './local-auth.guard';

@Controller('auth')
export class AuthController {
  constructor(private readonly appService: AuthService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Request() req: any) {
    return this.appService.login(req.user);
  }

  @Post('signup')
  @UseInterceptors(
    FileInterceptor('avatar', {
      dest: 'assets/images/',
    }),
  )
  async register(
    @UploadedFile(
      new ParseFilePipe({
        fileIsRequired: true,
        validators: [
          // ... Set of file validator instances here
          new MaxFileSizeValidator({ maxSize: 100000 * 100 }),
          new FileTypeValidator({
            fileType: /(^image+(\/(jpg|png|gif|bmp))$)/,
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
