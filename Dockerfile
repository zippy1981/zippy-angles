# Stage 1: Build the Angular app
FROM node:18 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:1.25.2-alpine as prod-stage
COPY --from=build /app/dist/zippy-angles /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
