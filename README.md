[![Docker Build](https://github.com/anasoid/docker-jmeter/actions/workflows/docker.yml/badge.svg)](https://github.com/anasoid/docker-jmeter/actions/workflows/docker.yml)

# Docker-JMeter

You can find image on [Docker Hub](https://hub.docker.com/r/anasoid/jmeter)

# Quick reference

- **Where to get help**:
  - [Issues](https://github.com/anasoid/docker-jmeter/issues)
  - [Discussions](https://github.com/anasoid/docker-jmeter/discussions)
  - [Documentation](https://github.com/anasoid/docker-jmeter)

## Image version

- [`latest`, `5.4`, `5.4-11-jre`,`5.4.3`, `5.4.3-11-jre`](https://github.com/anasoid/docker-jmeter/blob/master/5.x/eclipse-temurin/Dockerfile)
- [`latest-11-jdk`, `5.4-11-jdk`,`5.4.3-11-jdk`](https://github.com/anasoid/docker-jmeter/blob/master/5.x/eclipse-temurin/Dockerfile)
- [`latest-plugins`, `5.4-plugins`, `5.4-plugins-11-jre`, `5.4.3-plugins`, `5.4.3-plugins-11-jre`](https://github.com/anasoid/docker-jmeter/blob/master/5.x/eclipse-temurin/Dockerfile)
- [`latest-plugins-11-jdk`, `5.4-plugins-11-jdk`, `5.4.3-plugins-11-jdk`](https://github.com/anasoid/docker-jmeter/blob/master/5.x/eclipse-temurin/Dockerfile)

## Features

1. Smallest size with ~110MB.
2. Two versions: Native JMeter version and JMeter version with pre-configured plugin manager.
3. Timeout for execution. After the timeout, docker will be stopped, even if test is not finished. This is helpful to force stop JMeter docker after a timeout.
4. Download plugin with maven dependencies format.
5. Download plugin with list of URLs.
6. Download plugin with plugin manager (Only plugins versions).
7. Use plugins from folders.
8. Check JMX Test (Only plugins versions)
9. Split CSV Data on multi nodes.
10. Execute pre/post test shell scripts.
11. Separate Project configuration from node configuration, to separate configuration from execution team and developer teams.
12. Isolate output folder (logs, jtl files, html report).
13. Any JMeter parameter can be used in arguments.
14. No limitation is introduced by this image, JMeter can be used directly, if custom input parameters are not used.
15. A delay can be performed using the check on the existence of a file.
16. Monitoring Jmx with Jolokia (Work only with JDK image).

## Content

- [Docker-JMeter](#docker-jmeter)
- [Quick reference](#quick-reference)
  - [Image version](#image-version)
  - [Features](#features)
  - [Content](#content)
- [Image Variants](#image-variants)
  - [`jmeter:<jmeter-version>-plugins-*`](#jmeterjmeter-version-plugins-)
- [Folder structure](#folder-structure)
  - [Image Folder structure](#image-folder-structure)
  - [Project folder structure](#project-folder-structure)
  - [User Folder structure](#user-folder-structure)
  - [Configuration](#configuration)
- [Exposed Port](#exposed-port)
- [Plugins installation](#plugins-installation)
  - [Download plugins with Maven format](#download-plugins-with-maven-format)
  - [Download Plugins dependencies with Maven format](#download-plugins-dependencies-with-maven-format)
  - [Download dependencies with zip format](#download-dependencies-with-zip-format)
  - [Download dependencies automatically with plugin manager](#download-dependencies-automatically-with-plugin-manager)
  - [Download dependencies list with plugin manager](#download-dependencies-list-with-plugin-manager)
  - [Use plugins and dependencies from project or user folder](#use-plugins-and-dependencies-from-project-or-user-folder)
  - [Use plugins and dependencies as additional lib](#use-plugins-and-dependencies-as-additional-lib)
- [Test plan check](#test-plan-check)
- [Split CSV files](#split-csv-files)
- [Timezone](#timezone)
- [JMX Monitoring (Jolokia)](#jmx-monitoring-jolokia)
- [Examples](#examples)
  - [Change JVM Memory size](#change-jvm-memory-size)
  - [Use additional properties files](#use-additional-properties-files)
  - [Use timeout for JMeter execution](#use-timeout-for-jmeter-execution)
  - [Execute before-test.sh/after-test.sh only on master node](#execute-before-testshafter-testsh-only-on-master-node)
  - [Generate JTL, HTML report and log file](#generate-jtl-html-report-and-log-file)
  - [Using additional raw JMeter parameter](#using-additional-raw-jmeter-parameter)
  - [Using raw JMeter parameter](#using-raw-jmeter-parameter)
  - [Using wait to be Ready](#using-wait-to-be-ready)
- [Best Practice](#best-practice)

# Image Variants

The `JMeter` images come in many flavors, each designed for a specific use case.
The images version are based on component used to build image:

1. **JMeter Version**: 5.4.3 -> default for 5.4.
2. **JVM Version**: e.g.: (-11-jre, default for 11-jre),a nd default JVM is `eclipse-temurin`.
3. **plugins** : Pre-installed [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) and [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/). This will provide the image with the feature to check JMX file and download plugins with plugin manager.

## `jmeter:<jmeter-version>-plugins-*`

This is the image containing pre-installed [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) and [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/). This will provide the image with the feature to check JMX file and download plugins with plugin manager.

# Folder structure

## Image Folder structure

| Folder/files                      | Environnement variable  | Description                                                                                                                                                                                                                                      |
| --------------------------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `/opt/apache-jmeter`              | `JMETER_HOME`           | Installation of JMeter                                                                                                                                                                                                                           |
| `/jmeter/additional/lib`          | `JMETER_ADDITIONAL_LIB` | Additional lib for JMeter folder using property [plugin_dependency_paths](https://jmeter.apache.org/usermanual/properties_reference.html#classpath)                                                                                              |
| `/jmeter/additional/lib/ext`      | `JMETER_ADDITIONAL_EXT` | Additional plugins for JMeter folder using property [search_paths](https://jmeter.apache.org/usermanual/properties_reference.html#classpath)                                                                                                     |
| `/jmeter/project`                 | `PROJECT_PATH`          | Project folder, where JMX file should be present.                                                                                                                                                                                                |
| `/jmeter/workspace`               | `WORKSPACE_TARGET`      | If duplicate project folder by ( `$CONF_COPY_TO_WORKSPACE` ) is chosen, this will be the target folder. `$WORKSPACE_PATH` will be the workspace folder depending on duplicating project or not it will be `$WORKSPACE_TARGET` or `$PROJECT_PATH` |
| `/jmeter/user`                    | `USER_PATH`             | Second folder to be used to configure project execution.                                                                                                                                                                                         |
| `/jmeter/out`                     | `OUTPUT_PATH`           | Base output folder                                                                                                                                                                                                                               |
| `$OUTPUT_PATH/jtl`                | `OUTPUT_JTL_PATH`       | Default JTL destination folder                                                                                                                                                                                                                   |
| `$OUTPUT_PATH/log`                | `OUTPUT_LOG_PATH`       | Default log destination folder                                                                                                                                                                                                                   |
| `$OUTPUT_PATH/csv`                | `OUTPUT_CSV_PATH`       | Default divided csv destination folder, only for debugging.                                                                                                                                                                                      |
| `$OUTPUT_PATH/dashboard`          | `OUTPUT_REPORT_PATH`    | Default Report base folder                                                                                                                                                                                                                       |
| `/opt/jolokia/jolokia.properties` | `JOLOKIA_CONFIG`        | Jolokia configuration file : <https://jolokia.org/reference/html/agents.html#agents-jvm>                                                                                                                                                         |

## Project folder structure

| Folder/files                                    | Description                                                                                                                                     |
| ----------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `lib`                                           | lib folder, files in this folder will be copied to $JMETER_HOME/lib                                                                             |
| `plugins`                                       | plugins folder, files in this folder will be copied to $JMETER_HOME/lib/ext                                                                     |
| `dependencies/url.txt`                          | URLs in this file will be download and extracted to $JMETER_HOME                                                                                |
| `dependencies/settings.xml`                     | settings.xml used by maven, if there is any need to not authentication for maven repository or a custom one                                     |
| `dependencies/plugins-lib-dependencies.xml`     | Dependencies plugins, jar present in this file will be copied to folder "lib" in JMeter.                                                        |
| `dependencies/plugins-lib-ext-dependencies.xml` | Plugins, jar present in this file will be copied to folder "lib/ext" in JMeter.                                                                 |
| `scripts/after-test.sh`                         | This script will be executed after JMeter test ends. To be executed after test in slave, JMeter should be stopped after test wth `$JMETER_EXIT` |
| `scripts/before-test.sh`                        | This script will be executed before JMeter starts                                                                                               |
| `jmeter.properties`                             | default value properties file.                                                                                                                  |

Example of project folder: (<https://github.com/anasoid/docker-jmeter/tree/develop/tests/projects/sample1>)

## User Folder structure

Same as project folder, the only different JMX file is not used from this folder.

Example of User folder: (<https://github.com/anasoid/docker-jmeter/tree/develop/tests/users/user1>)

## Configuration

This environment variable are input to configure JMeter and execution:

| Environment variables                    | default value       | Description                                                                                                                                                                                                                                                                                                                                                                      |
| ---------------------------------------- | ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `CONF_SKIP_PLUGINS_INSTALL`              | `false`             | Skip plugin installation from maven, and url.txt and folder.                                                                                                                                                                                                                                                                                                                     |
| `CONF_SKIP_PRE_ACTION`                   | `false`             | Skip Execution of after-test.sh                                                                                                                                                                                                                                                                                                                                                  |
| `CONF_SKIP_POST_ACTION`                  | `false`             | Skip Execution of before-test.sh                                                                                                                                                                                                                                                                                                                                                 |
| `CONF_COPY_TO_WORKSPACE`                 | `false`             | Copy project to `$WORKSPACE_TARGET`, before executing test, this feature can be used with `$CONF_CSV_SPLIT` to not change file on project folder which can be shared with multiple slave.                                                                                                                                                                                        |
| `CONF_WITH_JOLOKIA`                      | `false`             | Enable Jolokia for JMX monitoring, This featue work only with JDK version                                                                                                                                                                                                                                                                                                        |
| `CONF_EXEC_IS_SLAVE`                     | `false`             | True, to be slave node, this will add " --server " as argument for JMeter, this variable can be also used on scripts to choose if action can be executed also on slave or only master.                                                                                                                                                                                           |
| `CONF_EXEC_WORKER_COUNT`                 | `1`                 | Total JMeter slave count. This value is used only to split CSV file.                                                                                                                                                                                                                                                                                                             |
| `CONF_EXEC_WORKER_NUMBER`                | `1`                 | Number of current slave. This value is used only to split CSV file.                                                                                                                                                                                                                                                                                                              |
| `CONF_EXEC_WAIT_BEFORE_TEST`             | `0`                 | Wait in second before start JMeter.                                                                                                                                                                                                                                                                                                                                              |
| `CONF_EXEC_WAIT_AFTER_TEST`              | `1`                 | Wait in second after stopping JMeter.                                                                                                                                                                                                                                                                                                                                            |
| `CONF_EXEC_TIMEOUT`                      | `2592000`           | Default timeout in second, after this duration JMeter and docker container wil be stopped, default (30 days)                                                                                                                                                                                                                                                                     |
| `CONF_READY_WAIT_FILE`                   |                     | The file to wait until exists to start execution, if file start with `/` the file will be considered as absolute path, if not it will be considered as relative path to `PROJECT_PATH`, this option is useful when we need to start container than copy project to container without using mount specially on Kubernetes.                                                        |
| `CONF_READY_WAIT_TIMEOUT`                | `1200`              | Default timeout for waiting the ready file to be present in seconds                                                                                                                                                                                                                                                                                                              |
| `CONF_CSV_SPLIT`                         | `false`             | Split csv file on `$CONF_EXEC_WORKER_COUNT` and take the part `CONF_EXEC_WORKER_COUNT`                                                                                                                                                                                                                                                                                           |
| `CONF_CSV_SPLIT_PATTERN`                 | `**`                | Pattern used to choose csv file to be divided, a default filter (\*.csv) is already used so only CSV files are concerned by this split, the pattern is applied relative path for file, so patten can be applied on folder or file name. (e.g.: "./data/\*.csv" for csv file in "data" folder, "./data/\*\_split.csv" for csv files in "data" folder with suffix "\*\_split.csv") |
| `CONF_CSV_WITH_HEADER`                   | `true`              | Split CSV file has header or not.                                                                                                                                                                                                                                                                                                                                                |
| `CONF_CSV_DIVIDED_TO_OUT`                | `true`              | Copy divided files to `$OUTPUT_CSV_PATH`, only for debugging.                                                                                                                                                                                                                                                                                                                    |
| `JMETER_JMX`                             |                     | JMX test file.                                                                                                                                                                                                                                                                                                                                                                   |
| `JMETER_EXIT`                            | `false`             | Force exit after test on all node.                                                                                                                                                                                                                                                                                                                                               |
| `JMETER_PROPERTIES_FILES`                | `jmeter.properties` | List of properties file to be used as additional properties, (e.g. :"size.properties preprod.properties"). This list will be added from project and user folder if file is present.                                                                                                                                                                                              |
| `JMETER_JTL_FILE`                        |                     | Name of JTL result file, will be saved in folder `$OUTPUT_JTL_PATH`                                                                                                                                                                                                                                                                                                              |
| `JMETER_LOG_FILE`                        | `jmeter.log`        | JMeter log file name `$OUTPUT_LOG_PATH`                                                                                                                                                                                                                                                                                                                                          |
| `JMETER_REPORT_NAME`                     |                     | HTML report name, will be saved in folder `$OUTPUT_REPORT_PATH`                                                                                                                                                                                                                                                                                                                  |
| `JMETER_JVM_ARGS`                        |                     | JMeter JVM arguments, can configure JVM with Xmx, Xms, ...                                                                                                                                                                                                                                                                                                                       |
| `JMETER_JVM_EXTRA_ARGS`                  |                     | A second Parameter to configure JVM arguments.                                                                                                                                                                                                                                                                                                                                   |
| `JMETER_DEFAULT_ARGS`                    | `--nongui`          | A default arguments, by default JMeter is executed in a non-GUI mode (headless mode).                                                                                                                                                                                                                                                                                            |
| `JMETER_CHECK_ONLY`                      | `false`             | Don't execute test but only do a check with [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/), available only on (variant plugins)                                                                                                                                                                                                                      |
| `JMETER_PLUGINS_MANAGER_INSTALL_LIST`    |                     | Install list of plugins using [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) (e.g. : "jpgc-json=2.2,jpgc-casutg=2.0"),                                                                                                                                                                                                                              |
| `JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX` | `false`             | Install needed plugins for jmx file automatically using [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/)                                                                                                                                                                                                                                              |

# Exposed Port

1. The exposed RMI port is 1099. See doc on <https://jmeter.apache.org/usermanual/remote-test.html>
2. Jolokia port 8778.

# Plugins installation

Plugins can be provided in many ways.
We distinguish two types of lib dependencies, the plugins and plugins dependencies. In JMeter they are in different folders lib/ext and lib respectively.

## Download plugins with Maven format

In `project folder` or `user folder` put maven xml file `dependencies/plugins-lib-ext-dependencies.xml`, use exclusion with \* to not download dependencies of JARs, only JAR referenced in file will be used.
JAR from this file will be downloaded to folder `$JMETER_HOME/lib/ext`.
e.g.:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>org.anasoid.jmeter.docker</groupId>
  <version>1</version>
  <packaging>pom</packaging>

  <artifactId>sample-lib-ext</artifactId>

  <dependencies>
    <dependency>
      <groupId>com.blazemeter</groupId>
      <artifactId>jmeter-plugins-random-csv-data-set</artifactId>
      <version>0.8</version>
      <exclusions>
        <exclusion>
          <groupId>*</groupId>
          <artifactId>*</artifactId>
        </exclusion>
      </exclusions>
    </dependency>
    <dependency>
      <groupId>kg.apc</groupId>
      <artifactId>jmeter-plugins-graphs-additional</artifactId>
      <version>2.0</version>
      <exclusions>
        <exclusion>
          <groupId>*</groupId>
          <artifactId>*</artifactId>
        </exclusion>
      </exclusions>
    </dependency>
  </dependencies>
</project>
```

## Download Plugins dependencies with Maven format

In `project folder` or `user folder` put maven XML file `dependencies/plugins-lib-dependencies.xml`, use exclusion with \* to not download dependencies of JARS, only JAR referenced in file will be used.
JAR from this file will be downloaded to folder `$JMETER_HOME/lib`.
Same format used by [plugins](#download-plugins-with-maven-format)

## Download dependencies with zip format

In `project folder` or `user folder` put file `dependencies/url.txt` with list of ZIP URLs. These ZIPs use the same JMeter structure with lib and lib/ext folder. The download ZIP links from website <https://jmeter-plugins.org/> are compatible with this file.

**N.B.**: ZIP files from <https://jmeter-plugins.org/> contain also JMeter plugin manager and other common JARs, these JARs can be duplicated when using multiple plugins.

## Download dependencies automatically with plugin manager

Use [version with plugins](#jmeterjmeter-version-plugins-) to have pre-configured plugin manager.
Use env variable JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX to download plugin before starting JMeter with [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/):

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX="true" \
anasoid/jmeter:latest-plugins
```

## Download dependencies list with plugin manager

Use [version with plugins](#jmeterjmeter-version-plugins-) to have pre-configured plugin manager.
Use env variable JMETER_PLUGINS_MANAGER_INSTALL_LIST to download plugin before starting JMeter with [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/):

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_PLUGINS_MANAGER_INSTALL_LIST="jpgc-json=2.2,jpgc-casutg=2.0" \
anasoid/jmeter:latest-plugins
```

## Use plugins and dependencies from project or user folder

Before starting JMeter, the folders `/jmeter/project/plugins` and `/jmeter/user/plugins` are copied to `$JMETER_HOME/lib/ext`, and folders `/jmeter/project/lib` and `/jmeter/user/lib` are copied to `$JMETER_HOME/lib`.

## Use plugins and dependencies as additional lib

Folder `/jmeter/additional/lib` is used as additional lib folder for JMeter and `/jmeter/additional/lib/ext` is used as additional folder for lib/ext folder in JMeter, files on those folders are not copied.

Example of use:

On the host machine prepare folder `/mylib` with additional libraries and a sub folder ext with plugins:

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-v /mylib/:/jmeter/additional/lib  \
-e JMETER_JMX="test-plan.jmx" \
anasoid/jmeter:latest-plugins
```

# Test plan check

Use [version with plugins](#jmeterjmeter-version-plugins-) to have pre-configured test plan check.
[Test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/) can verify test plan without executing test.

For example:

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_CHECK_ONLY="true" \
anasoid/jmeter:latest-plugins
```

**N.B** Test plan check can't detect plugins in additional folder, so [Use plugins and dependencies as additional lib.](#use-plugins-and-dependencies-as-additional-lib) will not work with test check even it work with execution.

# Split CSV files

Often we need that JMeter cluster doesn't use duplicated data (like logged user, ...). This can be achieved by splitting CSV files on the number of slaves.

To do this you can follow the following steps:

1. You have to identify CSV files that you want to be divided using a pattern `CONF_CSV_SPLIT_PATTERN`, for example use a prefix on all files (\*\_split.csv: login_split.csv)
1. You have to know the total number of slaves `CONF_EXEC_WORKER_COUNT` and identify each slave by number `CONF_EXEC_WORKER_NUMBER`.
1. CSV file will be replaced by the divided one. If project folder should not be modified, use option copy to workspace space `CONF_COPY_TO_WORKSPACE`, to duplicate project folder before starting execution.
1. You can also copy the divided files to out folder for debugging reasons to check divided data `CONF_CSV_DIVIDED_TO_OUT`

For example:

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e CONF_COPY_TO_WORKSPACE="true" \
-e CONF_EXEC_WORKER_COUNT="5" \
-e CONF_EXEC_WORKER_NUMBER="1" \
-e CONF_CSV_SPLIT_PATTERN="**_split.csv"
-e CONF_CSV_DIVIDED_TO_OUT="true" \
anasoid/jmeter:latest
```

# Timezone

Default timezone is GMT, if you need to change timezone to have correct time on jmeter log, you can set environment variables **TZ**, list of timezone are available here <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones>.

Example to change timezone :

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="basic-plan.jmx" \
-e TZ="Africa/Casablanca" \
anasoid/jmeter:latest
```

Timezone can also changed in file before-test.sh

```sh

export TZ="Africa/Casablanca"

```

# JMX Monitoring (Jolokia)

Enable Jolokia for Jmx monitoring, on port 8778, it's mandatory to use jdk version image with Jolokia.

```sh
docker run --rm \
-p 8778:8778
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="basic-plan.jmx" \
-e CONF_WITH_JOLOKIA="true" \
anasoid/jmeter:latest-plugins-11-jdk
```

Timezone can also changed in file before-test.sh

```sh

export TZ="Africa/Casablanca"

```

# Examples

## Change JVM Memory size

You can change memory size using `JMETER_JVM_ARGS` or `JMETER_JVM_EXTRA_ARGS`, e.g. :

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="basic-plan.jmx" \
-e JMETER_JVM_ARGS=" -Xmx2G -Xms1G " \
anasoid/jmeter:latest
```

## Use additional properties files

You can add additional properties files using `JMETER_PROPERTIES_FILES`. Default value is jmeter.properties (If a file _jmeter.properties_ is found in [project folder](#project-folder-structure) or in [user folder](#user-folder-structure) it will be added to JMeter execution.).

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_PROPERTIES_FILES=" common.properties prepord.properties " \
anasoid/jmeter:latest
```

## Use timeout for JMeter execution

You can set a timeout for execution by value of `CONF_EXEC_TIMEOUT`. After that timeout JMeter is stopped and after that the container will be stopped also. The timeout is useful on cloud infrastructure when docker container has a cost. If for any reason the test is not started, the slave will shutdown after timeout. Timeout value should be bigger by a good margin than the time needed by the test to not be stopped during execution.

For example: timeout of 1 hour

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e CONF_EXEC_TIMEOUT="3600" \
anasoid/jmeter:latest
```

## Execute before-test.sh/after-test.sh only on master node

before-test.sh/after-test.sh are executed on all nodes, but you can add conditions in a script file to test if a block of code should be executed.

For example: timeout of 1 hour

```sh
   if [[ "$CONF_EXEC_IS_SLAVE" == "true" ]]; then
     # Slave block
     else
     # Master block
   fi

```

## Generate JTL, HTML report and log file

Output base folder is pre-configured as `/jmeter/out`, you can choose name of report `JMETER_REPORT_NAME` which will be stored in `/jmeter/out/dashboard` and JTL file name `JMETER_JTL_FILE` which will be stored in `/jmeter/out/jtl/` and jmeter log file (default jmeter.log) `JMETER_LOG_FILE` which will be stored in `/jmeter/out/log/`.

For example: generate JTL and dashboard with a name chosen as _myreport_

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="basic-plan.jmx" \
-e JMETER_JTL_FILE=out.jtl \
-e JMETER_LOG_FILE=out.log \
-e JMETER_REPORT_NAME=myreport \
anasoid/jmeter:latest
```

JTL file will be in `/jmeter/out/jtl/out.jtl`, report folder will be in `/jmeter/out/dashboard/myreport` and JMeter log will be in `/jmeter/out/log/out.log`

## Using additional raw JMeter parameter

Arguments passed to docker container are finally passed to JMeter, so you can use any additional arguments

For example: disable RMI SSL, and add custom properties `numberthread`

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="basic-plan.jmx" \
-e JMETER_JTL_FILE=out.jtl \
-e JMETER_LOG_FILE=out.log \
-e JMETER_REPORT_NAME=myreport \
anasoid/jmeter:latest -Jserver.rmi.ssl.disable=true -Jnumberthread=500
```

## Using raw JMeter parameter

The pre-configured folder structure can be ignored, and JMeter can be used as standard way.

The following arguments will be added by default:

1. `--nongui` from `JMETER_DEFAULT_ARGS`
2. ' --jmeterlogfile /jmeter/out/log/jmeter.log' from value `JMETER_LOG_FILE`, if `JMETER_LOG_FILE` is empty or a custom `--jmeterlogfile` or `-j` to have new JMeter log file this arguments will be not add to JMeter.

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/myproject \
anasoid/jmeter:latest -t /myprojet/test.jmx -Jthread=50 -q /myproject/prop.properties
```

## Using wait to be Ready

Container can be started and wait until ready fie will be present.

The following arguments will be added by default:

1. `--nongui` from `JMETER_DEFAULT_ARGS`
2. ' --jmeterlogfile /jmeter/out/log/jmeter.log' from value `JMETER_LOG_FILE`, if `JMETER_LOG_FILE` is empty or a custom `--jmeterlogfile` or `-j` to have new JMeter log file this arguments will be not add to JMeter.

```sh
docker run --name jmeter \
-e CONF_READY_WAIT_FILE="ready.txt" \
-e JMETER_JMX="basic-plan.jmx" \
 anasoid/jmeter:latest

 #Copy test to container
 docker cp ${PWD}/tests/projects/sample1/basic-plan.jmx jmeter:/jmeter/project

#Start test by creation of file ready.txt
 docker exec jmeter touch /jmeter/project/ready.txt

```

# Best Practice

1. Use container instance by execution.
2. Force exit container after execution, use `JMETER_EXIT` to force remote exit after test execution.
3. In environment when container has a cost (like AWS Fargate, Azure container instance, Google cloud run) and there is a risk of JMeter not stopping correctly (for any reason like slaves are started but master fail, ...), than use timeout execution `CONF_EXEC_TIMEOUT` in seconds. Be careful, timeout should be greater than the max duration possible for test.
4. Adapt memory needed by the JVM using `JMETER_JVM_ARGS` and don't use a huge Memory instance, it's preferable to have smallest one: less than 8GB.
5. Always use properties to parameterize tests (<https://jmeter.apache.org/usermanual/best-practices.html#parameterising_tests>), than you can save multi pre-configured properties files to be used with `JMETER_PROPERTIES_FILES`.
