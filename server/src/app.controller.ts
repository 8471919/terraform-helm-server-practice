import core from "@nestia/core";
import { Controller } from "@nestjs/common";

import { MyGlobal } from "./global";
import { diffDateString } from "./utils/functions/diff-date-string.function";

@Controller()
export class AppController {
  private readonly bootTime = new Date();
  private readonly mode: string = MyGlobal.env.NODE_ENV;

  @core.TypedRoute.Get()
  async healthCheck(): Promise<any> {
    const curTime = new Date();

    return {
      message: "I am OK! Have a nice day!",
      mode: this.mode,
      bootTime: this.bootTime,
      serverTime: curTime,
      uptime: diffDateString(curTime.getTime() - this.bootTime.getTime()),
      version: process.env.npm_package_version, // 추가된 부분
    };
  }
}
