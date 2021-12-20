# Example of custom Java runtime using jlink in a multi-stage container build
FROM maven:3.8-eclipse-temurin-11-alpine  as maven-install-build

# Define your base image
FROM eclipse-temurin:11-jre-alpine

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

ARG JMETER_VERSION="5.4.2"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JAVA_HOME=/opt/java/openjdk

ENV DEPENCENCIES_TMP_PATH /tmp/dependencies 
ENV DEPENCENCIES_PATH /jmeter/internal/dependencies
ENV PLUGINS_PATH /jmeter/plugins

ENV USER_PATH /jmeter/user
ENV USER_DEPENCENCIES_PATH $USER_PATH/dependencies
ENV USER_MAVEN_SETTINGS $USER_DEPENCENCIES_PATH/settings.xml

ENV SCRIPTS_PATH /scripts

ENV MVN_OPTION="-DoverWriteReleases=true -DoverWriteSnapshots=true -DoverWriteIfNewer=true -DexcludeTransitive=true"
#INPUT ENV


COPY --from=maven-install-build /usr/share/maven $MAVEN_HOME

COPY scripts  $SCRIPTS_PATH
COPY dependencies $DEPENCENCIES_PATH

# Install extra packages
# Set TimeZone, See: https://github.com/gliderlabs/docker-alpine/issues/136#issuecomment-612751142
ARG TZ="Europe/Amsterdam"
ENV TZ ${TZ}

ENV PATH "${SCRIPTS_PATH}:${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${JMETER_HOME}/bin:${PATH}"

RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update  curl unzip bash \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/* \
	&& echo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Installing Jmeter ${JMETER_VERSION}%%%%%%%%%%%%%%%%%%%%%%%%%%%% \
	&& mkdir -p /tmp/dependencies  \
	&& curl -Z -L ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf ${JMETER_HOME}/docs \
	&& rm -rf ${JMETER_HOME}/licenses \
	&& rm -rf ${JMETER_HOME}/printable_docs \
	&& echo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%CLEANUP TMP%%%%%%%%%%%%%%%%%%%%%%%%%%%% \
	&& rm -rf /tmp/dependencies \
	&& rm -rf $DEPENCENCIES_TMP_PATH \
	&& rm -rf $HOME/.m2/repository/kg

RUN echo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Installing Jmeter Plugins%%%%%%%%%%%%%%%%%%%%%%%%%%%% \
    && plancheck-download.sh \ 
	&& plugin-manager-download.sh \ 
	&& plugin-manager-download.sh \ 
	&& mvn-download.sh -f plugins-lib-dependencies.xml -t ${JMETER_HOME}/lib \
	&& echo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%CLEANUP TMP%%%%%%%%%%%%%%%%%%%%%%%%%%%% \
	&& rm -rf $DEPENCENCIES_TMP_PATH \
	&& rm -rf $HOME/.m2/repository/kg


# Entrypoint has same signature as "jmeter" command


WORKDIR	${JMETER_HOME}

ENTRYPOINT ["entrypoint.sh"]
