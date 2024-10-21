import dayjs from "dayjs";
import timezone from "dayjs/plugin/timezone";
import utc from "dayjs/plugin/utc";
import dotenv from "dotenv";
import dotenvExpand from "dotenv-expand";
import { Singleton } from "tstl";
import typia from "typia";

dayjs.extend(utc);
dayjs.extend(timezone);

/* eslint-disable */
export class MyGlobal {
  public static testing: boolean = false;

  // public static readonly prisma: PrismaClient = new PrismaClient();

  public static get env(): MyGlobal.IEnvironments {
    return environments.get();
  }

  /**
   * Current mode.
   *
   *   - local: The server is on your local machine.
   *   - dev: The server is for the developer.
   *   - prod: The server is for the production service.
   */
  public static get mode(): "local" | "dev" | "prod" | "test" {
    return (modeWrapper.value ??= environments.get().NODE_ENV);
  }

  public static get date(): typeof dayjs {
    return dayjs;
  }

  /**
   * Set current mode.
   *
   * @param mode The new mode
   */
  public static setMode(mode: typeof MyGlobal.mode): void {
    typia.assert<typeof mode>(mode);
    modeWrapper.value = mode;
  }
}

interface Mode {
  value?: "local" | "dev" | "prod" | "test";
}

const modeWrapper: Mode = {};

export namespace MyGlobal {
  export interface IEnvironments {
    NODE_ENV: "local" | "dev" | "prod" | "test";
    PORT: `${number}`;
    DATABASE_URL: string;
  }
}

const environments = new Singleton(() => {
  const env = dotenv.config({
    path: process.env.NODE_ENV ? `.env.${process.env.NODE_ENV}` : ".env.local",
  });

  dotenvExpand.expand(env);
  return typia.assert<MyGlobal.IEnvironments>(process.env);
});
