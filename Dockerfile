# Use official Node image to build the app
FROM node:16 AS build

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install --legacy-peer-deps

COPY . ./
RUN npm run build || echo "Build step skipped or not defined"

# Use Nginx to serve the static build
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
