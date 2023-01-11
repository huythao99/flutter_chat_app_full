import {
  HttpException,
  HttpStatus,
  Injectable,
  NestMiddleware,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Request, NextFunction } from 'express';
import { AuthService } from 'src/auth/auth.service';
import { jwtConstants } from 'src/auth/constants';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
  constructor(
    private jwtService: JwtService,
    private authService: AuthService,
  ) {}

  async use(req: Request, next: NextFunction) {
    const token = req.headers['authorization'];
    if (token) {
      const user = this.jwtService.verify(token, {
        secret: jwtConstants.secret,
      });
      const doc = await this.authService.findUser(user._id);

      if (doc) {
        req.user = user;
        next();
      } else {
        throw new HttpException('Token is invalid', HttpStatus.UNAUTHORIZED);
      }
    } else {
      throw new HttpException('Token is invalid', HttpStatus.BAD_REQUEST);
    }
  }
}
