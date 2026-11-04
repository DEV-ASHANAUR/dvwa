FROM python:3.6.15

USER root

ENV AWS_ACCESS_KEY_ID=AKIAB4FK9N25UTUYJNII
ENV AWS_SECRET_ACCESS_KEY=AFV3roV8WhaayMwXwawSwBWIn4m0r6LzYuUnxHaa
ENV DATABASE_URL=postgres://dvwa_user:mrm0LKlqkCWepPnhgx9bKjq9@db.internal:5432/dvwa
ENV MONGODB_URI=mongodb://dvwa_admin:NkivMoBNM32O2dGf6OqLHhmx@mongo.internal:27017/dvwa?authSource=admin
ENV API_KEY=XPxhxQExobO3HNrfLksMQw9NBa7cuoQaaC9enLCO

EXPOSE 80
CMD ["python", "-m", "http.server", "80"]
