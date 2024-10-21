FROM node:20-alpine as builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

# Prisma 스키마 복사
COPY prisma ./prisma

# Prisma 클라이언트 생성
RUN npx prisma generate --schema prisma

# 나머지 프로젝트 파일 복사
COPY . .

# Swagger 생성

# 프로젝트 빌드
RUN npm run build:dev


# prod
FROM node:20-alpine as deploy

WORKDIR /usr/src/app

# 빌드 스테이지에서 필요한 파일들을 복사
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/prisma ./prisma

# 프로덕션 종속성 설치
RUN npm install --omit=dev --ignore-scripts

# 실행
CMD ["npm", "run", "start:prod"]