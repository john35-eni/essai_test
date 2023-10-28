FROM node:18 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

# Expose the desired port (e.g., 8080)
EXPOSE 8080

# Copiez le fichier de configuration dans le conteneur
COPY myapp.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]

