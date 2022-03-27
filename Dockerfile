FROM node:16.13.0-slim as builder
WORKDIR /app
COPY . /app

# ENV variables
ARG MYSQLHOST
ARG MYSQLPORT
ARG MYSQLUSER
ARG MYSQLPASSWORD
ARG MYSQLDATABASE
ARG MAILGUN_SMTP_LOGIN
ARG MAILGUN_SMTP_PASSWORD
ARG PORT
ARG CLOUDINARY_URLs

RUN mkdir -p themes
RUN yarn install
RUN yarn start
RUN ["bash", "bin/theme.sh"]


FROM ghost:4.41-alpine as ghost
WORKDIR /var/lib/ghost
USER node
RUN mkdir -p $GHOST_CONTENT/adapters/storage/cloudinary
COPY --from=builder /app/node_modules/ghost-storage-cloudinary $GHOST_CONTENT/adapters/storage/cloudinary
COPY --from=builder /app/config.production.json /var/lib/ghost/config.production.json
COPY --from=builder /app/themes $GHOST_CONTENT/themes

# For debbugging purposes only
# RUN ls -l /var/lib/ghost/
# RUN ls -l $GHOST_CONTENT/themes
# RUN ls -l $GHOST_CONTENT/adapters/storage/cloudinary