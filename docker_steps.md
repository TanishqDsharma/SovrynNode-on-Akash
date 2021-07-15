#  Containerizing Your Application:

Now,To deploy our application on Akash, we need to first containerize it. To containerize your application follow the below steps:

<b>To containerize your application follow the below steps:</b>
* Inside your Application Directory <b>"Create a DockerFile"</b> 
```docker
FROM node:12

ENV WHICHNET=test


RUN apt-get update && apt-get -y install procps

WORKDIR /app

###

COPY package.json /app
COPY package-lock.json /app

RUN npm install --loglevel verbose 
RUN npm install -g mocha nodemon

### Add application files

COPY . /app


RUN npm run build-client


RUN apt-get install -y curl jq
RUN node -r esm util/approval.js

CMD ["sh", "-c", "bash /app/get_secret"]

EXPOSE 3000

CMD ["sh", "-c", "npm run start:${WHICHNET}"]

```

* <b>To build the image execute the below command:</b>

  ``` 
  docker build -t <docker-image-name-here> .   
  ```
  
  ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/4.png)
  
  The above command will create a docker image with the name you provide above.
  
* <b>To test your image execute the below command:</b>
   
   ``` 
   docker run -p 3000:3000 <docker-image-name> 
   ```   
  ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/5.png)
  
## PUSH IMAGE TO DOCKERHUB:

After creating the docker image we need to make it publicly available so that it can be used with Akash Cloud.So, to push the docker image follow the below steps:

* The above command would have created a container id, to view the container id issue the command :
     ``` 
     docker ps -a  
     ```
     
  ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/6.png)

 
* Now Use the below commands to create a new image from exisiting container and push it to the docker hub

   ```
   docker commit container-id <docker-hub-username>/<docker-image-name>
   ```

   ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/8.png)


   ```
   docker push <docker-hub-username>/<docker-image-name>
   ```
   ![alt text](https://github.com/TanishqDsharma/SovrynNode-on-Akash/blob/main/screenshots/9.png)


Finally, we are finished with pushing our docker image to dockerhub, now this image is publicly available and can be used by Akash for deployment purposes.
