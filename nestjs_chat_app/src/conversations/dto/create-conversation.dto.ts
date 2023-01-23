import { IsArray, IsMongoId, IsNotEmpty } from 'class-validator';

export class CreateConversationDto {
  @IsNotEmpty()
  @IsMongoId()
  sender: string;

  @IsNotEmpty()
  @IsMongoId()
  @IsArray()
  receiver: string[];

  @IsNotEmpty()
  message: string;
}
