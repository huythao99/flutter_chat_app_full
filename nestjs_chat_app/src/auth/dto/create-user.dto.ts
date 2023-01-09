import {
  IsEmail,
  IsFirebasePushId,
  IsMobilePhone,
  IsNotEmpty,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateUserDto {
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @MinLength(6, {
    message: 'Password at least 6 characters',
  })
  @MaxLength(32, {
    message: 'Password less than 32 characters',
  })
  password: string;

  @IsNotEmpty()
  username: string;

  @IsNotEmpty()
  @IsMobilePhone('vi-VN')
  phone: string;

  // @IsNotEmpty()
  // avatar: Express.Multer.File;

  @IsNotEmpty()
  @IsFirebasePushId()
  fcmtoken: string;
}
