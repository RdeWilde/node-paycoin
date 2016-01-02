# Dockerfile for running node-paycoin tests
FROM rdewilde/paycoin-testnet-box
MAINTAINER Robert de Wilde <rdewildenl@gmail.com>

# install node.js
USER root
RUN apt-get install --yes curl
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install --yes nodejs

# set permissions for tester user on project
ADD . /home/tester/node-paycoin
RUN chown --recursive tester:tester /home/tester/node-paycoin

# install module dependencies
USER tester
WORKDIR /home/tester/node-paycoin
RUN npm install

# run test suite
CMD ["npm", "test"]
