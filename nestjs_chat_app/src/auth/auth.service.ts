import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectModel } from '@nestjs/mongoose';
import { jwtConstants } from './constants';
import { LoginUserDto } from './dto/login-user.dto';
import { Model } from 'mongoose';
import { User, UserDocument } from 'src/schema/user.schema';
import { CreateUserDto } from './dto/create-user.dto';
import { CloudinaryService } from 'src/cloudinary/cloudinary.service';
import { TYPE } from 'src/constants';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(User.name) private userModel: Model<UserDocument>,
    private jwtService: JwtService,
    private cloudinary: CloudinaryService,
  ) {}

  getHello(): string {
    return 'Hello World!';
  }

  async findUser(id: string) {
    const res = await this.userModel.findById(id).exec();
    return res;
  }

  async findUserByEmail(email: string) {
    const res = await this.userModel.findOne({ email: email }).exec();
    return res;
  }

  async validateUser(email: string, password: string): Promise<any> {
    const user = await this.userModel.findOne({ email: email });
    if (user && user.password == password) {
      return user.toObject();
    }
    throw new HttpException('Email or password is wrong', HttpStatus.NOT_FOUND);
  }

  async login(user: LoginUserDto) {
    const payload = { username: user.email, sub: jwtConstants.secret };

    return {
      access_token: this.jwtService.sign(payload, {
        expiresIn: 60,
      }),
      refresh_token: this.jwtService.sign(payload),
      ...user,
    };
  }

  async register(user: CreateUserDto, avatar: Express.Multer.File) {
    const res = await this.userModel
      .findOne({ email: user.email, password: user.password })
      .exec();
    if (res) {
      throw new HttpException('Email already used', HttpStatus.BAD_REQUEST);
    }
    const newAvatar = await this.cloudinary.uploadImage(TYPE.AVATAR, avatar);
    const newUser = await this.userModel.create({
      ...user,
      avatar: newAvatar.url,
    });
    const payload = { username: user.email, sub: jwtConstants.secret };
    return {
      access_token: this.jwtService.sign(payload, {
        expiresIn: 60,
      }),
      refresh_token: this.jwtService.sign(payload),
      ...newUser.toObject(),
      avatar: newAvatar.url,
    };
  }
}
