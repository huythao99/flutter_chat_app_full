import { ConfigOptions, v2 } from 'cloudinary';
import { CLOUDINARY } from './constants';

export const CloudinaryProvider = {
  provide: CLOUDINARY,
  useFactory: (): ConfigOptions => {
    return v2.config({
      cloud_name: 'dbhjxaqce',
      api_key: '314688645395247',
      api_secret: 'lYTuaa26jmkuTNX4ZSQZDAexyi0',
    });
  },
};
