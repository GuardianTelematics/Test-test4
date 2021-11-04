FROM node:12-slim
WORKDIR /app
RUN apt-get update && apt-get upgrade -y

COPY . ./
RUN npm install

EXPOSE 5000

CMD [ "npm", "start"]