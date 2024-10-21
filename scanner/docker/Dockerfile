FROM docker.io/kalilinux/kali-rolling:latest
LABEL Name=1 Version=0.0.1
RUN apt-get -y update
RUN apt-get install -y nmap xsltproc

WORKDIR /app
COPY ./app /app/

CMD [ "./script.sh" ]