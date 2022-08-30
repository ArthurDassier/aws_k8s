FROM node:12-alpine

ENV SONAR_SCANNER_VERSION=4.7.0.2747-linux
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre
ENV SONAR_SCANNER_OPTS="-Xmx512m -Dsonar.host.url=https://sonarqube.digital.homeoffice.gov.uk/"
ENV PATH $PATH:/sonar-scanner/bin:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ADD "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip" /

RUN set -x \
        && apk add --no-cache unzip openjdk8-jre \
        && unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip \
        && ln -s /sonar-scanner-${SONAR_SCANNER_VERSION} /sonar-scanner \
        && rm -f sonar-scanner-cli-*.zip
