# Example of custom Java runtime using jlink in a multi-stage container build
FROM maven:3.8-eclipse-temurin-11-alpine  as maven-install-build

# Define your base image
FROM eclipse-temurin:11-jre-alpine

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

ARG JMETER_VERSION="5.4.2"
ENV	JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JAVA_HOME=/opt/java/openjdk

#docker build
ENV DEPENCENCIES_TMP_PATH /tmp/dependencies 
ENV DEPENCENCIES_PATH /jmeter/internal/dependencies
ENV PLUGINS_PATH /jmeter/plugins

#JMETER
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_ADDITIONAL_HOME /jmeter/additional
ENV JMETER_ADDITIONAL_LIB $JMETER_ADDITIONAL_HOME/lib
ENV JMETER_ADDITIONAL_EXT $JMETER_ADDITIONAL_LIB/ext

ENV USER_PATH /jmeter/user
ENV PROJECT_PATH /jmeter/project
ENV WORKSPACE_TARGET /jmeter/workspace
ENV OUTPUT_PATH /jmeter/out

#USER
ENV USER_DEPENCENCIES_PATH $USER_PATH/dependencies
ENV USER_PLUGINS_PATH $USER_PATH/plugins
ENV USER_LIB_PATH $USER_PATH/lib
ENV USER_PLUGINS_URL_FILE $USER_PATH/url.txt
ENV USER_SCRIPTS_BASE_PATH $PROJECT_PATH/scripts
ENV USER_SCRIPTS_POST_FILE $USER_SCRIPTS_BASE_PATH/post-test.sh
ENV USER_SCRIPTS_PRE_FILE $USER_SCRIPTS_BASE_PATH/pre-test.sh
ENV USER_MAVEN_SETTINGS $USER_DEPENCENCIES_PATH/settings.xml
ENV USER_JMETER_PROPERTIES $USER_DEPENCENCIES_PATH/additional.propertes

#PROJECT

ENV PROJECT_DEPENCENCIES_PATH $PROJECT_PATH/dependencies
ENV PROJECT_PLUGINS_PATH $PROJECT_PATH/plugins
ENV PROJECT_LIB_PATH $PROJECT_PATH/lib
ENV PROJECT_PLUGINS_URL_FILE $PROJECT_PLUGINS_PATH/url.txt
ENV PROJECT_SCRIPTS_BASE_PATH $PROJECT_PATH
ENV PROJECT_SCRIPTS_POST_ACTION_FILE $PROJECT_SCRIPTS_BASE_PATH/post-test.sh
ENV PROJECT_SCRIPTS_PRE_ACTION_FILE  $PROJECT_SCRIPTS_BASE_PATH/pre-test.sh
ENV PROJECT_MAVEN_SETTINGS $PROJECT_DEPENCENCIES_PATH/settings.xml
ENV PROJECT_JMETER_PROPERTIES $PROJECT_DEPENCENCIES_PATH/additional.propertes

#CONFIG
ENV CONF_USE_ADDITIONAL_LIB false
ENV CONF_CLEAN_ADDITIONAL_LIB false
ENV CONF_SKIP_PLUGINS_INSTALL false
ENV CONF_SKIP_PRE_ACTION false
ENV CONF_SKIP_POST_ACTION false
ENV CONF_COPY_TO_WORKSPACE false

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

ENV PATH "${SCRIPTS_PATH}:${SCRIPTS_PATH}/internal:${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${JMETER_HOME}/bin:${PATH}"

RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update  curl unzip bash \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/* \
	&& echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Installing Jmeter ${JMETER_VERSION} %%%%%%%%%%%%%%%%%%%%%%%%%%%%" \
	&& mkdir -p /tmp/dependencies  \
	&& echo ${PATH}  \
	&& curl -Z -L ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& echo "" >> $JMETER_HOME/bin/jmeter.properties  \
	&& echo "#DOCKER-JMETER-CONFG" >> $JMETER_HOME/bin/jmeter.properties  \
	&& echo "search_paths=$JMETER_ADDITIONAL_EXT" >> $JMETER_HOME/bin/jmeter.properties  \
	&& echo "plugin_dependency_paths=$JMETER_ADDITIONAL_LIB" >> $JMETER_HOME/bin/jmeter.properties  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf ${JMETER_HOME}/docs \
	&& rm -rf ${JMETER_HOME}/licenses \
	&& rm -rf ${JMETER_HOME}/printable_docs \
	&& echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CLEANUP TMP %%%%%%%%%%%%%%%%%%%%%%%%%%%%" \
	&& rm -rf /tmp/dependencies \
	&& rm -rf $DEPENCENCIES_TMP_PATH \
	&& rm -rf $MAVEN_CONFIG/repository/kg




RUN echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Installing Jmeter Plugins %%%%%%%%%%%%%%%%%%%%%%%%%%%%" \
	&& plancheck-download.sh \ 
	&& plugin-manager-download.sh \ 
	&& plugin-manager-download.sh \ 
	&& mvn-download.sh -f plugins-lib-dependencies.xml -t ${JMETER_HOME}/lib \
	&& mkdir -p $JMETER_ADDITIONAL_LIB  \
	&& mkdir -p $JMETER_ADDITIONAL_EXT  \
	&& echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CLEANUP TMP %%%%%%%%%%%%%%%%%%%%%%%%%%%%" \
	&& rm -rf $DEPENCENCIES_TMP_PATH \
	&& rm -rf ${SCRIPTS_PATH}/internal \
	&& rm -rf $MAVEN_CONFIG/repository/kg


# Entrypoint has same signature as "jmeter" command


WORKDIR	${JMETER_HOME}

ENTRYPOINT ["entrypoint.sh"]
