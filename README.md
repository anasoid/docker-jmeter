[![Docker Build](https://github.com/anasoid/docker-jmeter/actions/workflows/docker.yml/badge.svg)](https://github.com/anasoid/docker-jmeter/actions/workflows/docker.yml)

# docker-jmeter

# Quick reference

- **Where to get help**:  
  [Issues](https://github.com/anasoid/docker-jmeter/issues)  
  [Discussions](https://github.com/anasoid/docker-jmeter/discussions)

## Image version

- [`latest`, `5.4`, `5.4-11-jre`, `5.4-eclipse-temurin-11-jre-alpine`, `5.4-eclipse-temurin-11-jre`, `5.4.3`, `5.4.3-11-jre`, `5.4.3-eclipse-temurin-11-jre-alpine`, `5.4.3-eclipse-temurin-11-jre`](https://github.com/anasoid/docker-jmeter/blob/master/5.4/eclipse-temurin/11-jre-alpine/Dockerfile)
- [`latest-plugins`, `5.4-plugins`, `5.4-plugins-11-jre`, `5.4-plugins-eclipse-temurin-11-jre-alpine`, `5.4-plugins-eclipse-temurin-11-jre`, `5.4.3-plugins`, `5.4.3-plugins-11-jre`, `5.4.3-plugins-eclipse-temurin-11-jre-alpine`, `5.4.3-plugins-eclipse-temurin-11-jre`](https://github.com/anasoid/docker-jmeter/blob/master/5.4/eclipse-temurin/11-jre-alpine/Dockerfile)

## Features:

1. Smallest size with ~100MB.
2. Download plugin with maven dependencies format.
3. Download plugin with list of url.
4. Download plugin with plugin manager (Only plugins versions) .
5. Use plugins from folders.
6. Check Jmx Test (Only plugins versions)
7. Split CSV Data on multi nodes.
8. Execute pre/post test shell scripts.
9. Separate Project configuration from node configuration, to separate configuration from execution team and developer teams.
10. Isolate output folder (logs, jtl files, html report).
11. Any Jmeter parameter can be used in arguments.
12. No limitation is introduced by this image, jmeter can be used directly if custom input parameters are not used.

# Image Variants

The `Jmeter` images come in many flavors, each designed for a specific use case.
The images version are based on component used to build image :

1. **Jmeter Version** : 5.4.3 -> default for 5.4.
2. **JVM Version** : Ex :(eclipse-temurin-11-jre, default for 11-jre)
3. **Image base** : alpine is the default image.
4. **plugins** : Pre-installed [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) and [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/). This give image to use feature to check JMX file and download plugins with plugin manager.

## `jmeter:<jmeter-version>-plugins-*`

This is image contain pre-installed [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) and [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/). This give image to use feature to check JMX file and download plugins with plugin manager.

## `Jmeter:<version>-alpine`

This image is based on the popular [Alpine Linux project](https://alpinelinux.org), available in [the `alpine` official image](https://hub.docker.com/_/alpine). Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

## Image Folder structure:

| Folder/files           | description            |     |     |     |
| ---------------------- | ---------------------- | --- | --- | --- |
| /opt/apache-jmeter     | JMETER_HOME            |     |     |     |
| /jmeter/additional     | JMETER_ADDITIONAL_HOME |     |     |     |
| /jmeter/additional/lib | JMETER_ADDITIONAL_LIB  |     |     |     |
| /jmeter/additional/ext | JMETER_ADDITIONAL_EXT  |     |     |     |
| /jmeter/project        | PROJECT_PATH           |     |     |     |
| /jmeter/user           | USER_PATH              |     |     |     |
| /jmeter/workspace      | WORKSPACE_TARGET       |     |     |     |
| /jmeter/out            | OUTPUT_PATH            |     |     |     |
| /jmeter/out/jtl        | OUTPUT_JTL_PATH        |     |     |     |
| /jmeter/out/log        | OUTPUT_LOG_PATH        |     |     |     |
| /jmeter/out/dashboard  | OUTPUT_REPORT_PATH     |     |     |     |

## Project Folder structure:

| Folder/files                                  | Description |     |     |     |
| --------------------------------------------- | ----------- | --- | --- | --- |
| lib                                           |             |     |     |     |
| plugins                                       |             |     |     |     |
| dependencies/url.txt                          |             |     |     |     |
| dependencies/settings.xml                     |             |     |     |     |
| dependencies/plugins-lib-dependencies.xml     |             |     |     |     |
| dependencies/plugins-lib-ext-dependencies.xml |             |     |     |     |
| scripts/after-test.sh                         |             |     |     |     |
| scripts/before-test.sh                        |             |     |     |     |
| jmeter.properties                             |             |     |     |     |

## Env Variables:

| Folder/files                           | default value     | Description |     |     |
| -------------------------------------- | ----------------- | ----------- | --- | --- |
| CONF_SKIP_PLUGINS_INSTALL              | false             |             |     |     |
| CONF_SKIP_PRE_ACTION                   | false             |             |     |     |
| CONF_SKIP_POST_ACTION                  | false             |             |     |     |
| CONF_COPY_TO_WORKSPACE                 | false             |             |     |     |
| EXEC_IS_SLAVE                          | false             |             |     |     |
| CONF_EXEC_WORKER_COUNT                 | 1                 |             |     |     |
| CONF_EXEC_WORKER_NUMBER                | 1                 |             |     |     |
| CONF_EXEC_WAIT_BEFORE_TEST             | 0                 |             |     |     |
| CONF_EXEC_WAIT_AFTER_TEST              | 1                 |             |     |     |
| CONF_EXEC_TIMEOUT                      | 18144000          |             |     |     |
| CONF_CSV_SPLIT                         | false             |             |     |     |
| CONF_CSV_SPLIT_PATTERN                 | \*\*              |             |     |     |
| CONF_CSV_WITH_HEADER                   | true              |             |     |     |
| CONF_CSV_SPLITTED_TO_OUT               | true              |             |     |     |
| JMETER_JMX                             |                   |             |     |     |
| JMETER_EXIT                            | false             |             |     |     |
| JMETER_PROPERTIES_FILES                | jmeter.properties |             |     |     |
| JMETER_JTL_FILE                        |                   |             |     |     |
| JMETER_LOG_FILE                        | jmeter.log        |             |     |     |
| JMETER_REPORT_NAME                     |                   |             |     |     |
| JMETER_JVM_ARGS                        |                   |             |     |     |
| JMETER_JVM_EXTRA_ARGS                  |                   |             |     |     |
| JMETER_DEFAULT_ARGS                    | --nongui          |             |     |     |
| JMETER_CHECK_ONLY                      | false             |             |     |     |
| JMETER_PLUGINS_MANAGER_INSTALL_LIST    |                   |             |     |     |
| JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX | false             |             |     |     |

## Image on Folder Structure:

Docker image for [Apache JMeter](http://jmeter.apache.org).
This Docker image can be run as the `jmeter` command.
Find Images of this repo on [Docker Hub](https://hub.docker.com/r/anasoid/jmeter).

## Building

With the script [build.sh](build.sh) the Docker image can be build
from the [Dockerfile](Dockerfile) but this is not really necessary as

### Build Options

## Running

The Docker image will accept the same parameters as `jmeter` itself, assuming
you run JMeter non-GUI with `-n`.

There is a shorthand [run.sh](run.sh) command.
See [test.sh](test.sh) for an example of how to call [run.sh](run.sh).

## User Defined Variables

This is a standard facility of JMeter: settings in a JMX test script
may be defined symbolically and substituted at runtime via the commandline.
These are called JMeter User Defined Variables or UDVs.

## Installing JMeter plugins

To run the container with custom JMeter plugins installed you need to mount a volume /plugins with the .jar files. For example:

```sh
sudo docker run --name ${NAME} -i -v ${LOCAL_PLUGINS_FOLDER}:/plugins -v ${LOCAL_JMX_WORK_DIR}:${CONTAINER_JMX_WORK_DIR} -w ${PWD} ${IMAGE} $@
```

## Specifics

The Docker image built from the
[Dockerfile](Dockerfile) inherits from the [Alpine Linux](https://www.alpinelinux.org) distribution:

> "Alpine Linux is built around musl libc and busybox. This makes it smaller
> and more resource efficient than traditional GNU/Linux distributions.
> A container requires no more than 8 MB and a minimal installation to disk
> requires around 130 MB of storage.
> Not only do you get a fully-fledged Linux environment but a large selection of packages from the repository."

See https://hub.docker.com/_/alpine/ for Alpine Docker images.

The Docker image will install (via Alpine `apk`) several required packages most specificly
the `OpenJDK Java JRE`. JMeter is installed by simply downloading/unpacking a `.tgz` archive
from http://mirror.serversupportforum.de/apache/jmeter/binaries within the Docker image.

A generic [entrypoint.sh](entrypoint.sh) is copied into the Docker image and
will be the script that is run when the Docker container is run. The
[entrypoint.sh](entrypoint.sh) simply calls `jmeter` passing all argumets provided
to the Docker container, see [run.sh](run.sh) script:

```
sudo docker run --name ${NAME} -i -v ${WORK_DIR}:${WORK_DIR} -w ${WORK_DIR} ${IMAGE} $@
```

## Credits

Thanks to https://github.com/justb4/docker-jmeter for providing the Dockerfiles that inspired me.
