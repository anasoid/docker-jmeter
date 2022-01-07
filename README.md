[![Docker Build](https://github.com/anasoid/docker-jmeter/actions/workflows/docker.yml/badge.svg)](https://github.com/anasoid/docker-jmeter/actions/workflows/docker.yml)

# docker-jmeter

# Quick reference

- **Where to get help**:  
  [Issues](https://github.com/anasoid/docker-jmeter/issues)  
  [Discussions](https://github.com/anasoid/docker-jmeter/discussions)

## Image version

- [`latest`, `5.4`, `5.4-11-jre`,`5.4.3`, `5.4.3-11-jre`](https://github.com/anasoid/docker-jmeter/blob/master/5.x/eclipse-temurin/Dockerfile)
- [`latest-plugins`, `5.4-plugins`, `5.4-plugins-11-jre`, `5.4.3-plugins`, `5.4.3-plugins-11-jre`](https://github.com/anasoid/docker-jmeter/blob/master/5.x/eclipse-temurin/Dockerfile)

## Features:

1. Smallest size with ~100MB.
2. Timeout for execution, after timeout docker will be stopped even test is not finished, this is helpfull to force stop jmeter docker after a timeout.
3. Download plugin with maven dependencies format.
4. Download plugin with list of url.
5. Download plugin with plugin manager (Only plugins versions) .
6. Use plugins from folders.
7. Check Jmx Test (Only plugins versions)
8. Split CSV Data on multi nodes.
9. Execute pre/post test shell scripts.
10. Separate Project configuration from node configuration, to separate configuration from execution team and developer teams.
11. Isolate output folder (logs, jtl files, html report).
12. Any Jmeter parameter can be used in arguments.
13. No limitation is introduced by this image, jmeter can be used directly if custom input parameters are not used.

## Content

- [docker-jmeter](#docker-jmeter)
- [Quick reference](#quick-reference)
  - [Image version](#image-version)
  - [Features:](#features)
  - [Content](#content)
- [Image Variants](#image-variants)
  - [`jmeter:<jmeter-version>-plugins-*`](#jmeterjmeter-version-plugins-)
- [Folder structure](#folder-structure)
  - [Image Folder structure](#image-folder-structure)
  - [Project folder structure](#project-folder-structure)
  - [User Folder structure](#user-folder-structure)
  - [Environement Variables](#environement-variables)
  - [Plugins](#plugins)
    - [Download plugins with Maven format](#download-plugins-with-maven-format)
    - [Download Plugins dependencies with Maven format](#download-plugins-dependencies-with-maven-format)
    - [Download dependencies with zip format](#download-dependencies-with-zip-format)
    - [Download dependencies automatically with plugin manager](#download-dependencies-automatically-with-plugin-manager)
    - [Download dependencies list with plugin manager](#download-dependencies-list-with-plugin-manager)
    - [Use plugins and dependencies from project or user folder](#use-plugins-and-dependencies-from-project-or-user-folder)
    - [Use plugins and dependencies as additional lib.](#use-plugins-and-dependencies-as-additional-lib)
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
| `/jmeter/out/csv`            | `OUTPUT_CSV_PATH`       | Default spllited csv destination folder, only for debugging.                                                                                                                                                                               |
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

| Folder/files                             | default value       | Description                                                                                                                                                                                                                                                                                                                                                     |
| ---------------------------------------- | ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `CONF_SKIP_PLUGINS_INSTALL`              | `false`             | Skip plugin installation from maven, and url.txt and folder.                                                                                                                                                                                                                                                                                                    |
| `CONF_SKIP_PRE_ACTION`                   | `false`             | Skip Execution of after-test.sh                                                                                                                                                                                                                                                                                                                                 |
| `CONF_SKIP_POST_ACTION`                  | `false`             | Skip Execution of before-test.sh                                                                                                                                                                                                                                                                                                                                |
| `CONF_COPY_TO_WORKSPACE`                 | `false`             | Copy project to `$WORKSPACE_TARGET`, before executing test, this feature can be used with `$CONF_CSV_SPLIT` to not change file on project folder who can be shared with multiple slave.                                                                                                                                                                         |
| `CONF_EXEC_IS_SLAVE`                     | `false`             | True, to be slave node, this will add " --server " as argument for jmeter, this variable can be also used on scripts to choose if action can be executed also on slave or only master.                                                                                                                                                                          |
| `CONF_EXEC_WORKER_COUNT`                 | `1`                 | Total jmeter slave count. This value is used only to split CSV file.                                                                                                                                                                                                                                                                                            |
| `CONF_EXEC_WORKER_NUMBER`                | `1`                 | Number of current slave. This value is used only to split CSV file.                                                                                                                                                                                                                                                                                             |
| `CONF_EXEC_WAIT_BEFORE_TEST`             | `0`                 | Wait in second before start Jmeter.                                                                                                                                                                                                                                                                                                                             |
| `CONF_EXEC_WAIT_AFTER_TEST`              | `1`                 | Wait in second after stopping Jmeter.                                                                                                                                                                                                                                                                                                                           |
| `CONF_EXEC_TIMEOUT`                      | `2592000`           | Default timeout in second, after this duration Jmeter adn docker container wil be stopped, default (30 days)                                                                                                                                                                                                                                                    |
| `CONF_CSV_SPLIT`                         | `false`             | Split csv file on `$CONF_EXEC_WORKER_COUNT` and take the part `CONF_EXEC_WORKER_COUNT`                                                                                                                                                                                                                                                                          |
| `CONF_CSV_SPLIT_PATTERN`                 | `\*\*`              | Pattern used to choose csv file to be spllited, a default filter (\*.csv) is already used so only csv file are concerned by this split, the pattern is applied relative path for file, so patten can be applied on folder or file name. (Ex : "./data/_.csv" for csv file in data folder, ./data/_\_split.csv for csv files in data folder with suffix \_split) |
| `CONF_CSV_WITH_HEADER`                   | `true`              | Split CSV file has header or not.                                                                                                                                                                                                                                                                                                                               |
| `CONF_CSV_SPLITTED_TO_OUT`               | `true`              | Copy splitted files to `$OUTPUT_CSV_PATH`, only for debugging.                                                                                                                                                                                                                                                                                                  |
| `JMETER_JMX`                             |                     | JMX test file.                                                                                                                                                                                                                                                                                                                                                  |
| `JMETER_EXIT`                            | `false`             | Force exit after test on all node.                                                                                                                                                                                                                                                                                                                              |
| `JMETER_PROPERTIES_FILES`                | `jmeter.properties` | List of properties file to be used as additional properties, (ex :"size.properties preprod.properties") this list will be add from project and user folder if file is present.                                                                                                                                                                                  |
| `JMETER_JTL_FILE`                        |                     | Name of jtl result file , will be saved in folder `$OUTPUT_JTL_PATH`                                                                                                                                                                                                                                                                                            |
| `JMETER_LOG_FILE`                        | `jmeter.log`        | Jmeter log file name `$OUTPUT_LOG_PATH`                                                                                                                                                                                                                                                                                                                         |
| `JMETER_REPORT_NAME`                     |                     | Html report name , will be saved in folder `$OUTPUT_REPORT_PATH`                                                                                                                                                                                                                                                                                                |
| `JMETER_JVM_ARGS`                        |                     | Jmeter jvm arguments, can configure JVM with Xmx Xms, ..                                                                                                                                                                                                                                                                                                        |
| `JMETER_JVM_EXTRA_ARGS`                  |                     | A second Parameter to configure jvm arguments.                                                                                                                                                                                                                                                                                                                  |
| `JMETER_DEFAULT_ARGS`                    | `--nongui`          | A default arguments, by default jmeter is executed in anon gui mode.                                                                                                                                                                                                                                                                                            |
| `JMETER_CHECK_ONLY`                      | `false`             | Don't execute test but only do a check with [test plan check tool](https://jmeter-plugins.org/wiki/TestPlanCheckTool/) , available only on (variant plugins)                                                                                                                                                                                                    |
| `JMETER_PLUGINS_MANAGER_INSTALL_LIST`    |                     | Install list of plugins using [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/) (Ex : "jpgc-json=2.2,jpgc-casutg=2.0"),                                                                                                                                                                                                               |
| `JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX` | `false`             | Install needed plugins for jmx file automatically using [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/)                                                                                                                                                                                                                             |

## Plugins

Plugins can be provided in many ways.
We distinguish two type of lib dependencies, the plugins and plugins dependencies. In Jmeter they are in different folders lib/ext and lib respectively.

### Download plugins with Maven format

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

### Download Plugins dependencies with Maven format

In `project folder` or `user folder` put maven xml file `dependencies/plugins-lib-dependencies.xml`, use exclusion with \* to not download dependencies of jar, only jar referenced in file will be used .
jar from this file will be downloaded to folder `$JMETER_HOME/lib`.
Same format used by [plugins](#download-plugins-with-maven-format)

### Download dependencies with zip format

In `project folder` or `user folder` put file `dependencies/url.txt` with list of zip urls, zip use the same jmeter structure with lib and lib/ext folder, the download zip links from website https://jmeter-plugins.org/ are compatible with this file.

**N.B** : zip file from https://jmeter-plugins.org/ contain also jmeter plugin manager and other common jars, this jars can be duplicated when using multiple plugins.

### Download dependencies automatically with plugin manager

Use [version with plugins](#jmeterjmeter-version-plugins-) to have pre-configured plugin manager.
Use env variable JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX to download plugin before starting jmeter with [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/):

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX="true" \
anasoid/jmeter:latest-plugins
```

### Download dependencies list with plugin manager

Use [version with plugins](#jmeterjmeter-version-plugins-) to have pre-configured plugin manager.
Use env variable JMETER_PLUGINS_MANAGER_INSTALL_LIST to download plugin before starting jmeter with [plugins manager](https://jmeter-plugins.org/wiki/PluginsManagerAutomated/):

```sh
docker run --rm \
-v ${PWD}/tests/projects/sample1/:/jmeter/project \
-e JMETER_JMX="test-plan.jmx" \
-e JMETER_PLUGINS_MANAGER_INSTALL_LIST="jpgc-json=2.2,jpgc-casutg=2.0" \
anasoid/jmeter:latest-plugins
```

### Use plugins and dependencies from project or user folder

before starting jmeter the folders `/jmeter/project/plugins` and `/jmeter/user/plugins` are copied to `$JMETER_HOME/lib/ext`, and folders `/jmeter/project/lib` and `/jmeter/user/lib` are copied to `$JMETER_HOME/lib`.

### Use plugins and dependencies as additional lib.

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

## Credits

Thanks to https://github.com/justb4/docker-jmeter for providing the Dockerfiles that inspired me.
