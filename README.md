[![Docker Build](https://github.com/anasoid/docker-jmeter/actions/workflows/docker.yml/badge.svg)](https://github.com/anasoid/docker-jmeter/actions/workflows/docker.yml)

# Docker-Jmeter

# Quick reference

- **Where to get help**:
  - [Issues](https://github.com/anasoid/docker-jmeter/issues)
  - [Discussions](https://github.com/anasoid/docker-jmeter/discussions)
  - [Documentation](https://github.com/anasoid/docker-jmeter)

## Image version

- [`latest`, `5.4`, `5.4-11-jre`,`5.4.3`, `5.4.3-11-jre`](https://github.com/anasoid/docker-jmeter/blob/master/5.x/eclipse-temurin/Dockerfile)
- [`latest-plugins`, `5.4-plugins`, `5.4-plugins-11-jre`, `5.4.3-plugins`, `5.4.3-plugins-11-jre`](https://github.com/anasoid/docker-jmeter/blob/master/5.x/eclipse-temurin/Dockerfile)

## Features

1. Smallest size with ~110MB.
2. Two version : Native Jmeter version and Jmeter version with pre-configured plugin manager.
3. Timeout for execution, after timeout docker will be stopped even test is not finished, this is helpful to force stop jmeter docker after a timeout.
4. Download plugin with maven dependencies format.
5. Download plugin with list of url.
6. Download plugin with plugin manager (Only plugins versions) .
7. Use plugins from folders.
8. Check Jmx Test (Only plugins versions)
9. Split CSV Data on multi nodes.
10. Execute pre/post test shell scripts.
11. Separate Project configuration from node configuration, to separate configuration from execution team and developer teams.
12. Isolate output folder (logs, jtl files, html report).
13. Any Jmeter parameter can be used in arguments.
14. No limitation is introduced by this image, jmeter can be used directly if custom input parameters are not used.

## Content

- [Docker-Jmeter](#docker-jmeter)
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
  - [Environement Variables](#environement-variables)
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
- [Examples](#examples)
  - [Change JVM Memory size](#change-jvm-memory-size)
  - [Use additional properties files](#use-additional-properties-files)
  - [Use timeout for jmeter execution](#use-timeout-for-jmeter-execution)
  - [Execute before-test.sh/after-test.sh only on master node](#execute-before-testshafter-testsh-only-on-master-node)
  - [Generate jtl , html report and log file](#generate-jtl--html-report-and-log-file)
  - [Using additional raw Jmeter parameter](#using-additional-raw-jmeter-parameter)
  - [Using raw Jmeter parameter](#using-raw-jmeter-parameter)
- [Credits](#credits)

# Image Variants

The `Jmeter` images come in many flavors, each designed for a specific use case.
The images version are based on component used to build image :

1. **Jmeter Version** : 5.4.3 -> default for 5.4.
2. **JVM Version** : Ex :(eclipse-temurin-11-jre, default for 11-jre)
3. **plugins** : Pre-installed [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) and [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/). This give image to use feature to check JMX file and download plugins with plugin manager.

## `jmeter:<jmeter-version>-plugins-*`

This is image contain pre-installed [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) and [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/). This give image to use feature to check JMX file and download plugins with plugin manager.

# Folder structure

## Image Folder structure

| Folder/files                 | Environnement variable  | Description                                                                                                                                                                                                                                |
| ---------------------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `/opt/apache-jmeter`         | `JMETER_HOME`           | Installation of Jmeter                                                                                                                                                                                                                     |
| `/jmeter/additional/lib`     | `JMETER_ADDITIONAL_LIB` | Additional lib for jmeter folder using property [plugin_dependency_paths](https://jmeter.apache.org/usermanual/properties_reference.html#classpath)                                                                                        |
| `/jmeter/additional/lib/ext` | `JMETER_ADDITIONAL_EXT` | Additional plugins for jmeter folder using property [search_paths](https://jmeter.apache.org/usermanual/properties_reference.html#classpath)                                                                                               |
| `/jmeter/project`            | `PROJECT_PATH`          | Project folder, where jmx file should be present.                                                                                                                                                                                          |
| `/jmeter/workspace`          | `WORKSPACE_TARGET`      | If choose duplicate project folder by ( `$CONF_COPY_TO_WORKSPACE` ), this will be the target folder. `$WORKSPACE_PATH` will be the workspace folder depend on duplicating project or not it will be `$WORKSPACE_TARGET` or `$PROJECT_PATH` |
| `/jmeter/user`               | `USER_PATH`             | Second folder to be used to configure project execution.                                                                                                                                                                                   |
| `/jmeter/out/jtl`            | `OUTPUT_JTL_PATH`       | Default JTL destination folder                                                                                                                                                                                                             |
| `/jmeter/out/log`            | `OUTPUT_LOG_PATH`       | Default log destination folder                                                                                                                                                                                                             |
| `/jmeter/out/csv`            | `OUTPUT_CSV_PATH`       | Default divided csv destination folder, only for debugging.                                                                                                                                                                                |
| `/jmeter/out/dashboard`      | `OUTPUT_REPORT_PATH`    | Default Report base folder                                                                                                                                                                                                                 |

## Project folder structure

| Folder/files                                    | Description                                                                                                                                    |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `lib`                                           | lib folder, file in this folder will be copied to $JMETER_HOME/lib                                                                             |
| `plugins`                                       | plugins folder, file in this folder will be copied to $JMETER_HOME/lib/ext                                                                     |
| `dependencies/url.txt`                          | urls in this file will be download and extracted to $JMETER_HOME                                                                               |
| `dependencies/settings.xml`                     | settings.xml used by maven, if there is any need to not authentication for maven repository or a custom one                                    |
| `dependencies/plugins-lib-dependencies.xml`     | Dependencies plugins, jar present in this file will be copied to folder "lib" in jmeter.                                                       |
| `dependencies/plugins-lib-ext-dependencies.xml` | Plugins, jar present in this file will be copied to folder "lib/ext" in jmeter.                                                                |
| `scripts/after-test.sh`                         | This script will be executed after jmeter test end , To be executed after test in slave jmeter should be stopped after test wth `$JMETER_EXIT` |
| `scripts/before-test.sh`                        | This script will be executed before jmeter start                                                                                               |
| `jmeter.properties`                             | default value properties file.                                                                                                                 |

## User Folder structure

Same as project folder, the only different jmx file is not used from this folder.

## Environement Variables

This environement variable are input to configure jmeter and execution:

| Folder/files                             | default value       | Description                                                                                                                                                                                                                                                                                                                                                    |
| ---------------------------------------- | ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `CONF_SKIP_PLUGINS_INSTALL`              | `false`             | Skip plugin installation from maven, and url.txt and folder.                                                                                                                                                                                                                                                                                                   |
| `CONF_SKIP_PRE_ACTION`                   | `false`             | Skip Execution of after-test.sh                                                                                                                                                                                                                                                                                                                                |
| `CONF_SKIP_POST_ACTION`                  | `false`             | Skip Execution of before-test.sh                                                                                                                                                                                                                                                                                                                               |
| `CONF_COPY_TO_WORKSPACE`                 | `false`             | Copy project to `$WORKSPACE_TARGET`, before executing test, this feature can be used with `$CONF_CSV_SPLIT` to not change file on project folder who can be shared with multiple slave.                                                                                                                                                                        |
| `CONF_EXEC_IS_SLAVE`                     | `false`             | True, to be slave node, this will add " --server " as argument for jmeter, this variable can be also used on scripts to choose if action can be executed also on slave or only master.                                                                                                                                                                         |
| `CONF_EXEC_WORKER_COUNT`                 | `1`                 | Total jmeter slave count. This value is used only to split CSV file.                                                                                                                                                                                                                                                                                           |
| `CONF_EXEC_WORKER_NUMBER`                | `1`                 | Number of current slave. This value is used only to split CSV file.                                                                                                                                                                                                                                                                                            |
| `CONF_EXEC_WAIT_BEFORE_TEST`             | `0`                 | Wait in second before start Jmeter.                                                                                                                                                                                                                                                                                                                            |
| `CONF_EXEC_WAIT_AFTER_TEST`              | `1`                 | Wait in second after stopping Jmeter.                                                                                                                                                                                                                                                                                                                          |
| `CONF_EXEC_TIMEOUT`                      | `2592000`           | Default timeout in second, after this duration Jmeter adn docker container wil be stopped, default (30 days)                                                                                                                                                                                                                                                   |
| `CONF_CSV_SPLIT`                         | `false`             | Split csv file on `$CONF_EXEC_WORKER_COUNT` and take the part `CONF_EXEC_WORKER_COUNT`                                                                                                                                                                                                                                                                         |
| `CONF_CSV_SPLIT_PATTERN`                 | `\*\*`              | Pattern used to choose csv file to be divided, a default filter (\*.csv) is already used so only csv file are concerned by this split, the pattern is applied relative path for file, so patten can be applied on folder or file name. (Ex : "./data/_.csv" for csv file in data folder, ./data/_\_split.csv for csv files in data folder with suffix \_split) |
| `CONF_CSV_WITH_HEADER`                   | `true`              | Split CSV file has header or not.                                                                                                                                                                                                                                                                                                                              |
| `CONF_CSV_DIVIDED_TO_OUT`                | `true`              | Copy divided files to `$OUTPUT_CSV_PATH`, only for debugging.                                                                                                                                                                                                                                                                                                  |
| `JMETER_JMX`                             |                     | JMX test file.                                                                                                                                                                                                                                                                                                                                                 |
| `JMETER_EXIT`                            | `false`             | Force exit after test on all node.                                                                                                                                                                                                                                                                                                                             |
| `JMETER_PROPERTIES_FILES`                | `jmeter.properties` | List of properties file to be used as additional properties, (ex :"size.properties preprod.properties") this list will be add from project and user folder if file is present.                                                                                                                                                                                 |
| `JMETER_JTL_FILE`                        |                     | Name of jtl result file , will be saved in folder `$OUTPUT_JTL_PATH`                                                                                                                                                                                                                                                                                           |
| `JMETER_LOG_FILE`                        | `jmeter.log`        | Jmeter log file name `$OUTPUT_LOG_PATH`                                                                                                                                                                                                                                                                                                                        |
| `JMETER_REPORT_NAME`                     |                     | Html report name , will be saved in folder `$OUTPUT_REPORT_PATH`                                                                                                                                                                                                                                                                                               |
| `JMETER_JVM_ARGS`                        |                     | Jmeter jvm arguments, can configure JVM with Xmx Xms, ..                                                                                                                                                                                                                                                                                                       |
| `JMETER_JVM_EXTRA_ARGS`                  |                     | A second Parameter to configure jvm arguments.                                                                                                                                                                                                                                                                                                                 |
| `JMETER_DEFAULT_ARGS`                    | `--nongui`          | A default arguments, by default jmeter is executed in anon gui mode.                                                                                                                                                                                                                                                                                           |
| `JMETER_CHECK_ONLY`                      | `false`             | Don't execute test but only do a check with [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/) , available only on (variant plugins)                                                                                                                                                                                                   |
| `JMETER_PLUGINS_MANAGER_INSTALL_LIST`    |                     | Install list of plugins using [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) (Ex : "jpgc-json=2.2,jpgc-casutg=2.0"),                                                                                                                                                                                                              |
| `JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX` | `false`             | Install needed plugins for jmx file automatically using [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/)                                                                                                                                                                                                                            |

# Plugins installation

Plugins can be provided in many ways.
We distinguish two type of lib dependencies, the plugins and plugins dependencies. In Jmeter they are in different folders lib/ext and lib respectively.

## Download plugins with Maven format

In `project folder` or `user folder` put maven xml file `dependencies/plugins-lib-ext-dependencies.xml`, use exclusion with \* to not download dependencies of jar, only jar referenced in file will be used .
jar from this file will be downloed to folder `$JMETER_HOME/lib/ext`.
ex:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>org.anasoid.jmeter.docker</groupId>
  <version>1</version>anlaanlahnjml.lanla
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

In `project folder` or `user folder` put maven xml file `dependencies/plugins-lib-dependencies.xml`, use exclusion with \* to not download dependencies of jar, only jar referenced in file will be used .
jar from this file will be downloaded to folder `$JMETER_HOME/lib`.
Same format used by [plugins](#download-plugins-with-maven-format)

## Download dependencies with zip format

In `project folder` or `user folder` put file `dependencies/url.txt` with list of zip urls, zip use the same jmeter structure with lib and lib/ext folder, the download zip links from website <https://jmeter-plugins.org/> are compatible with this file.

**N.B** : zip file from <https://jmeter-plugins.org/> contain also jmeter plugin manager and other common jars, this jars can be duplicated when using multiple plugins.

## Download dependencies automatically with plugin manager

Use [version with plugins](#jmeterjmeter-version-plugins-) to have pre-configured plugin manager.
Use env variable JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX to download plugin before starting jmeter with [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/):

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX="true" \
anasoid/jmeter:latest-plugins
```

## Download dependencies list with plugin manager

Use [version with plugins](#jmeterjmeter-version-plugins-) to have pre-configured plugin manager.
Use env variable JMETER_PLUGINS_MANAGER_INSTALL_LIST to download plugin before starting jmeter with [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/):

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_PLUGINS_MANAGER_INSTALL_LIST="jpgc-json=2.2,jpgc-casutg=2.0" \
anasoid/jmeter:latest-plugins
```

## Use plugins and dependencies from project or user folder

before starting jmeter the folders `/jmeter/project/plugins` and `/jmeter/user/plugins` are copied to `$JMETER_HOME/lib/ext`, and folders `/jmeter/project/lib` and `/jmeter/user/lib` are copied to `$JMETER_HOME/lib`.

## Use plugins and dependencies as additional lib

Folder `/jmeter/additional/lib` is used as additional lib folder for jmeter and `/jmeter/additional/lib/ext` is used as additional folder for lib/ext folder in jmeter, files on those folders are not copied.

ex of use :
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
[Test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/) can verify test plan without executing test :
Ex

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_CHECK_ONLY="true" \
anasoid/jmeter:latest-plugins
```

**N.B** Test plan check can't detect plugins in additional folder, so [Use plugins and dependencies as additional lib.](#use-plugins-and-dependencies-as-additional-lib) will not work with test check even it work with execution.

# Split CSV files

Many case when we need that jmeter cluster don't use duplicate data (like logged user, ..), this can be possible to split csv files on the number of salves.

To do this you can follow the following steps :

1. You have to identify csv files that you want to be divided by a pattern `CONF_CSV_SPLIT_PATTERN`,for example use a prefix on all files (\*\_split.csv: login_split.csv)
1. You have to know the total of slaves `CONF_EXEC_WORKER_COUNT` and identify each slave by number `CONF_EXEC_WORKER_NUMBER`.
1. csv file will be replaced by the divided one, so if project folder should not be modified, use option copy to workspace space `CONF_COPY_TO_WORKSPACE`, to duplicate project folder before starting execution.
1. You can also copy the divided files to out folder for debugging raison to check divided data `CONF_CSV_DIVIDED_TO_OUT`

Ex

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

# Examples

## Change JVM Memory size

You can change memory size using `JMETER_JVM_ARGS` or `JMETER_JVM_EXTRA_ARGS` Ex :

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_JVM_ARGS=" -Xmx2G -Xms1G " \
anasoid/jmeter:latest
```

## Use additional properties files

You can add additional properties files using `JMETER_PROPERTIES_FILES` default value is jmeter.properties (If a file _jmeter.properties_ is found in [project folder](#project-folder-structure) or in [user folder](#user-folder-structure) it will be added to jmeter execution.).

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_PROPERTIES_FILES=" common.properties prepord.properties " \
anasoid/jmeter:latest
```

## Use timeout for jmeter execution

You can force a timeout for execution by value of `CONF_EXEC_TIMEOUT` , after timeout jmeter is stopped and after that the container will be stopped also. The timeout is useful on cloud when docker container has a cost and if for any raison the test is not started the slave will shutdown after timeout. Timeout value should be enough bigger than the time needed by test to not stop it during execution

EX : timeout of 1 hour

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e CONF_EXEC_TIMEOUT="3600" \
anasoid/jmeter:latest
```

## Execute before-test.sh/after-test.sh only on master node

before-test.sh/after-test.sh are executed on all node but you can add condition in script file to test if a block should be executed.

EX : timeout of 1 hour

```sh
   if [[ "$CONF_EXEC_IS_SLAVE" == "true" ]]; then
     # Slave block
     else
     # Master block
   fi

```

## Generate jtl , html report and log file

Output base folder is pre-configured as `/jmeter/out`, you can choose name of report `JMETER_REPORT_NAME` will be stored in `/jmeter/out/dashboard` and jtl file name `JMETER_JTL_FILE` will be stored in `/jmeter/out/jtl/` and jmeter log file (default jmeter.log) `JMETER_LOG_FILE` will be stored in `/jmeter/out/log/`.

EX : generate jtl and dashboard

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_JTL_FILE=out.jtl \
-e JMETER_LOG_FILE=out.log \
-e JMETER_REPORT_NAME=myreport \
anasoid/jmeter:latest
```

JTL file will be in `/jmeter/out/jtl/out.jtl`, report folder will be in `/jmeter/out/dashboard/myreport` and jmeter log will be in `/jmeter/out/log/out.log`

## Using additional raw Jmeter parameter

argument passed to docker container are finally passed to jmeter, so you can use any additional arguments

Ex : disable rmi ssl, and add custom properties `numberthread`

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_JTL_FILE=out.jtl \
-e JMETER_LOG_FILE=out.log \
-e JMETER_REPORT_NAME=myreport \
anasoid/jmeter:latest -Jserver.rmi.ssl.disable=true -Jnumberthread=500
```

## Using raw Jmeter parameter

The pre-configured folder structure can be ignored, and jmeter can be used as standard way.

The following argument will be by default add:

1. `--nongui` from `JMETER_DEFAULT_ARGS`
2. ' --jmeterlogfile /jmeter/out/log/jmeter.log' from value `JMETER_LOG_FILE`, if `JMETER_LOG_FILE` is empty or a custom `--jmeterlogfile` or `-j` to have new jmeeter log file this arguments will be not add to jmeter.

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/myproject \
anasoid/jmeter:latest -t /myprojet/test.jmx -Jthread=50 -q /myproject/prop.properties
```

# Credits

Thanks to <https://github.com/justb4/docker-jmeter> for providing the Dockerfiles that inspired me.
