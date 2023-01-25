import { IsArray, IsMongoId, IsNotEmpty } from 'class-validator';

export class CreateMessageDto {
  @IsNotEmpty()
  @IsMongoId()
  sender: string;

  @IsNotEmpty()
  @IsArray()
  receiver: string[];

  conversation: string = '';

  message: string = '';

  image: string = '';
}
