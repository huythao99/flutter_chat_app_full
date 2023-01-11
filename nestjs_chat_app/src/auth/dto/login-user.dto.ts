import {
  IsEmail,
  IsFirebasePushId,
  IsNotEmpty,
  MaxLength,
  MinLength,
} from 'class-validator';

export class LoginUserDto {
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
  @IsFirebasePushId()
  fcmtoken: string;
}
