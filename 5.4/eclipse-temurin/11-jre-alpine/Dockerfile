# Example of custom Java runtime using jlink in a multi-stage container build
FROM maven:3.8-eclipse-temurin-11-alpine  as maven-install-build

# Define your base image
FROM eclipse-temurin:11-jre-alpine

LABEL org.opencontainers.image.authors="Anas OUFDOU <oufdou.anas@gmail.com>"


ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
ENV MVN_OPTION="-DoverWriteReleases=true -DoverWriteSnapshots=true -DoverWriteIfNewer=true -DexcludeTransitive=true"

ARG JMETER_VERSION="5.4.3"
ARG WITH_BASE_PLUGINS="true"
ENV WITH_BASE_PLUGINS ${WITH_BASE_PLUGINS}
ENV	JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JAVA_HOME=/opt/java/openjdk

#docker build
ENV SCRIPTS_PATH /scripts
ENV DEPENCENCIES_TMP_PATH /tmp/dependencies 
ENV DEPENCENCIES_PATH /jmeter/internal/dependencies
ENV PLUGINS_PATH /jmeter/plugins

#JMETER
ENV JMETER_HOME /opt/apache-jmeter
ENV JMETER_ADDITIONAL_HOME /jmeter/additional
ENV JMETER_ADDITIONAL_LIB $JMETER_ADDITIONAL_HOME/lib
ENV JMETER_ADDITIONAL_EXT $JMETER_ADDITIONAL_LIB/ext

ENV USER_PATH /jmeter/user
ENV PROJECT_PATH /jmeter/project
ENV WORKSPACE_TARGET /jmeter/workspace
ENV OUTPUT_PATH /jmeter/out
ENV OUTPUT_JTL_PATH $OUTPUT_PATH/jtl
ENV OUTPUT_LOG_PATH $OUTPUT_PATH/log
ENV OUTPUT_REPORT_PATH $OUTPUT_PATH/dashboard

#USER
ENV USER_DEPENCENCIES_PATH $USER_PATH/dependencies
ENV USER_PLUGINS_PATH $USER_PATH/plugins
ENV USER_LIB_PATH $USER_PATH/lib
ENV USER_PLUGINS_URL_FILE $USER_PATH/url.txt

ENV USER_MAVEN_SETTINGS $USER_DEPENCENCIES_PATH/settings.xml


#PROJECT

ENV PROJECT_DEPENCENCIES_PATH $PROJECT_PATH/dependencies
ENV PROJECT_PLUGINS_PATH $PROJECT_PATH/plugins
ENV PROJECT_LIB_PATH $PROJECT_PATH/lib
ENV PROJECT_PLUGINS_URL_FILE $PROJECT_PLUGINS_PATH/url.txt
ENV PROJECT_MAVEN_SETTINGS $PROJECT_DEPENCENCIES_PATH/settings.xml


#CONFIG
ENV CONF_SKIP_PLUGINS_INSTALL false
ENV CONF_SKIP_PRE_ACTION false
ENV CONF_SKIP_POST_ACTION false
ENV CONF_COPY_TO_WORKSPACE false

#EXECUTION
ENV EXEC_MODE master
ENV CONF_EXEC_WORKER_COUNT 1
ENV CONF_EXEC_WORKER_NUMBER 1
ENV CONF_EXEC_WAIT_BEFORE_TEST 0
ENV CONF_EXEC_WAIT_AFTER_TEST 1
ENV CONF_EXEC_TIMEOUT 999999

#DATA
ENV CONF_CSV_SPLIT false
ENV CONF_CSV_SPLIT_PATTERN **
ENV CONF_CSV_WITH_HEADER true
ENV CONF_CSV_SPLITTED_TO_OUT true


#JMETER
ENV JMETER_JMX ""
ENV JMETER_EXIT "false"
ENV JMETER_PROPERTIES_FILES "jmeter.propeties"
ENV JMETER_JTL_FILE ""
ENV JMETER_LOG_FILE "jmeter.log"
ENV JMETER_REPORT_NAME ""
ENV JMETER_EXTRA_ARGS ""
ENV JMETER_DEFAULT_ARGS " --nongui "
ENV JMETER_CHECK_ONLY "false"
ENV JMETER_PLUGINS_MANAGER_INSTALL_LIST ""
ENV JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX "false"

#INPUT ENV


COPY --from=maven-install-build /usr/share/maven $MAVEN_HOME

COPY scripts  $SCRIPTS_PATH
COPY dependencies $DEPENCENCIES_PATH

# Install extra packages
# Set TimeZone, See: https://github.com/gliderlabs/docker-alpine/issues/136#issuecomment-612751142
ARG TZ="Europe/Amsterdam"
ENV TZ ${TZ}

ENV PATH "${SCRIPTS_PATH}:${SCRIPTS_PATH}/internal:${SCRIPTS_PATH}/internal/build:${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${JMETER_HOME}/bin:${PATH}"

RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update  curl unzip bash \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/* \
	&& echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare folers %%%%%%%%%%%%%%%%%%%%%%%%%%%%" \
	&& mkdir -p $OUTPUT_PATH  \
	&& mkdir -p $OUTPUT_JTL_PATH  \
	&& mkdir -p $OUTPUT_LOG_PATH  \
	&& mkdir -p $OUTPUT_REPORT_PATH  \
	&& echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Installing Jmeter ${JMETER_VERSION} %%%%%%%%%%%%%%%%%%%%%%%%%%%%" \
	&& mkdir -p /tmp/dependencies  \
	&& echo ${PATH}  \
	&& curl -Z -L ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& mv -v /opt/apache-jmeter-${JMETER_VERSION} $JMETER_HOME \
	&& jmeter --version \
	&& echo "" >> $JMETER_HOME/bin/jmeter.properties  \
	&& echo "#DOCKER-JMETER-CONFG" >> $JMETER_HOME/bin/jmeter.properties  \
	&& echo "search_paths=$JMETER_ADDITIONAL_EXT" >> $JMETER_HOME/bin/jmeter.properties  \
	&& echo "plugin_dependency_paths=$JMETER_ADDITIONAL_LIB" >> $JMETER_HOME/bin/jmeter.properties  \
	&& rm -rf ${JMETER_HOME}/docs \
	&& rm -rf ${JMETER_HOME}/licenses \
	&& rm -rf ${JMETER_HOME}/printable_docs \
	&& echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Installing Jmeter Plugins %%%%%%%%%%%%%%%%%%%%%%%%%%%%" \
	&& if [[ "$WITH_BASE_PLUGINS" == "true" ]];then install-base-plugins.sh; else echo "without install-base-plugins";  fi \
	&& mkdir -p $JMETER_ADDITIONAL_LIB  \
	&& mkdir -p $JMETER_ADDITIONAL_EXT  \
	&& echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CLEANUP TMP %%%%%%%%%%%%%%%%%%%%%%%%%%%%" \
	&& rm -rf /tmp/dependencies \
	&& rm -rf $DEPENCENCIES_TMP_PATH \
	&& rm -rf ${SCRIPTS_PATH}/internal/build \
	&& rm -rf $MAVEN_CONFIG/repository/kg \
	&& rm -rf $DEPENCENCIES_PATH \
	&& rm -rf /jmeter.log






# Entrypoint has same signature as "jmeter" command


WORKDIR	${JMETER_HOME}

ENTRYPOINT ["entrypoint.sh"]
