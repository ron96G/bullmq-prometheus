ARG NODE_VERSION="20"

FROM node:$NODE_VERSION as builder

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install
COPY . .
RUN npm run build


FROM node:$NODE_VERSION

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install --omit=dev

COPY --from=builder /app/dist /app
COPY ./configs /app/configs

CMD [ "node", "server.js" ]
