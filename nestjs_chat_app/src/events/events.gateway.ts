import {
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Socket } from 'dgram';
import { Server } from 'socket.io';

@WebSocketGateway({
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

  @SubscribeMessage('events')
  handleEvent(
    client: Socket,
    data: {
      conversationID: string;
      userID: string;
    },
  ) {
    client.on('join channel', (socket) => {
      socket.join(data.conversationID);
    });
  }
}
