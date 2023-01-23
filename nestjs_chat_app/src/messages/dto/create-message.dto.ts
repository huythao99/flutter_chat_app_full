import { IsArray, IsMongoId, IsNotEmpty } from 'class-validator';

export class CreateMessageDto {
  @IsNotEmpty()
  @IsMongoId()
  sender: string;

  @IsNotEmpty()
  @IsMongoId()
  @IsArray()
  conversation: string[];

  message: string = '';

  image: string = '';
}
