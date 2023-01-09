import { Injectable } from '@nestjs/common';
import { UploadApiErrorResponse, UploadApiResponse, v2 } from 'cloudinary';
import { TYPE } from 'src/constants';

@Injectable()
export class CloudinaryService {
  async uploadImage(
    type: TYPE,
    file: Express.Multer.File,
  ): Promise<UploadApiResponse | UploadApiErrorResponse> {
    return v2.uploader.upload(file.buffer.toString(), {
      folder: type,
      filename_override: `${type}/${file.filename}`,
    });
  }
}
