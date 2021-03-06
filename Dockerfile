FROM java:8

COPY . deck/

WORKDIR deck

RUN docker/setup-apache2.sh && \
  GRADLE_USER_HOME=cache ./gradlew build -PskipTests && \
  mkdir -p /opt/deck/html/ && \
  cp build/webpack/* /opt/deck/html/ && \
  cd .. && \
  rm -rf deck

COPY docker/run-apache2.sh /deck/run-apache2.sh

CMD /deck/run-apache2.sh
