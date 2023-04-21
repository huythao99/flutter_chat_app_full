import {
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { EVENT } from './constants';

@WebSocketGateway(80, {
  cors: {
    origin: '*',
  },
})
export class EventsGateway {
  @WebSocketServer()
  server: Server;

  emitEvent(eventName: string, payload: any) {
    this.server.emit(eventName, payload);
  }

  emitEventToRoom(eventName: string, room: string, payload: any) {
    this.server.to(room).emit(eventName, payload);
  }

  @SubscribeMessage(EVENT.JOIN_ROOM)
  handleEvent(
    client: Socket,
    data: {
      conversationID: string;
      userID: string;
    },
  ) {
    client.join(data.conversationID);
  }
}
