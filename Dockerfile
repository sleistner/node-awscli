FROM node:8

RUN npm install -g serverless --update
RUN npm install -g yarn --update

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    python-dev \
    && apt-get clean

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && pip install awscli \
    && rm -rf get-pip.py

ADD . .
ENV PATH="./bin:${PATH}"

CMD ["aws-configure", "${AWS_ACCESS_KEY_ID}", "${AWS_SECRET_ACCESS_KEY}", "${AWS_REGION}"]
