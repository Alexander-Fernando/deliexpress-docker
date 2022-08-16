FROM node

WORKDIR /app

COPY package.json .

RUN npm install --save --legacy-peer-deps

COPY . .

EXPOSE 5000

CMD ["npm", "start"]