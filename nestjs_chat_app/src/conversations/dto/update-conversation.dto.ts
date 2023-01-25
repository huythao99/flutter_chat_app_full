import { IsMongoId, IsNotEmpty } from 'class-validator';

export class UpdateConversationDto {
  @IsNotEmpty()
  @IsMongoId()
  sender: string;

  @IsNotEmpty()
  message: string;

  @IsNotEmpty()
  @IsMongoId()
  conversation_id: string;
}
