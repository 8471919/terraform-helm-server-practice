import { NestFactory } from "@nestjs/core";

import { AppModule } from "./app.module";
import { MyGlobal } from "./global";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.setGlobalPrefix("/api", {
    exclude: ["/"],
  });

  app.enableCors();

  await app.listen(MyGlobal.env.PORT, "0.0.0.0");
}

bootstrap().catch((exp) => {
  console.log(exp);
  process.exit(-1);
});
