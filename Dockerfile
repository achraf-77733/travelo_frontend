FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json /app/

#Install dependencies
RUN npm install

#copier les fichiers de l'application
COPY . .

# Build the application
RUN npm run build
#reacte maintenant est compile mais pas encore servi

#servir l'application avec un serveur web nginx
FROM nginx:alpine
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx" , "-g", "daemon off;"]
