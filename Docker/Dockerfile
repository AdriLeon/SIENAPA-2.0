FROM ubuntu:22.04 
 
RUN apt-get update 
RUN apt-get install -y 
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y 

ENV requirements.txt /home/requirements.txt 
 
COPY requirements.txt ${requirements} 
RUN pip3 install -r requirements.txt 

WORKDIR /home/web/
