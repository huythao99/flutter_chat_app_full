export class GetMessageDto {
  conversationID: string = '';
  receiver: string[] = [];
  skip: number = 0;
}
