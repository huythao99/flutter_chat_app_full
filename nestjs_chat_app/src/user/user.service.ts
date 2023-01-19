import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { PER_PAGE } from 'src/constants';
import { User, UserDocument } from 'src/schema/user.schema';
import { SearchUserDto } from './dto/search-user.dto';

@Injectable()
export class UserService {
  constructor(@InjectModel(User.name) private userModel: Model<UserDocument>) {}

  async search(params: SearchUserDto) {
    const res = await this.userModel
      .find({
        $or: [
          { email: new RegExp(params.keyword, 'i') },
          { username: new RegExp(params.keyword, 'i') },
          { phone: new RegExp(params.keyword, 'i') },
        ],
      })
      .skip(params.page * PER_PAGE)
      .limit(PER_PAGE)
      .sort('asc')
      .exec();
    const total = await this.userModel
      .countDocuments({
        $or: [
          { email: new RegExp(params.keyword, 'i') },
          { username: new RegExp(params.keyword, 'i') },
          { phone: new RegExp(params.keyword, 'i') },
        ],
      })
      .exec();

    return {
      total,
      page: Number(params.page),
      users: [...res],
    };
  }
}
