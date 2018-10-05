FROM node:8.11.3

# Create app directory
RUN mkdir -p /usr/src/admin
WORKDIR /usr/src/admin

# Install app dependencies
COPY package.json /usr/src/admin/
RUN npm install

# Bundle app source
COPY . /usr/src/admin

RUN npm run build

EXPOSE 8080
CMD [ "node", "server.js" ]