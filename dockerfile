#Deriving the latest base image
FROM python:3.10.13-alpine3.17

#Labels as key value pair
LABEL Maintainer="myoung.me17"

# Any working directory can be chosen as per choice like '/' or '/home' etc
# i have chosen /usr/app/src
WORKDIR /usr/src/app

ENV MANUAL_LIST

RUN mkdir -p /data /config
RUN touch /usr/src/app/scraper.log
RUN ln -sf /proc/1/fd/1 /usr/src/app/scraper.log

#to COPY the remote file at working directory in container
#COPY hh.py /config/
# Now the structure looks like this '/usr/app/src/test.py'

RUN apk add --no-cache --update \
    python3 python3-dev gcc \
    gfortran musl-dev g++ \
    libffi-dev openssl-dev \
    libxml2 libxml2-dev \
    libxslt libxslt-dev \
    libjpeg-turbo-dev zlib-dev \
    mysql-client

RUN apk add --no-cache --update \
    bash jq

RUN pip install --upgrade cython \
    pip install --upgrade pip \
    pip install pandas \
    pip install homeharvest

#CMD instruction should be used to run the software
#contained by your image, along with any arguments.

#CMD [ "python3", "/config/hh.py" ]

#CMD python3 -u '/config/hh.py'; mysql -h ${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ygo < '/config/YGOSQL/YGOinsertTable.sql'

CMD /config/countyscrape.sh >/usr/src/app/scraper.log 2>&1
