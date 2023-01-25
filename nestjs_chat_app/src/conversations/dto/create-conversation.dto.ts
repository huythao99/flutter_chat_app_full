import { IsArray, IsMongoId, IsNotEmpty } from 'class-validator';

export class CreateConversationDto {
  @IsNotEmpty()
  @IsMongoId()
  sender: string;

  @IsNotEmpty()
  @IsArray()
  receiver: string[];

  @IsNotEmpty()
  message: string;
}
