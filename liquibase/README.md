# liquibase

## install liquibase cli

```shell
brew install liquibase
```

## get start

安裝 mysql driver
https://downloads.mysql.com/archives/c-j/
Product Version 選擇 `8.0.33`
Operating System 選擇 `Platform Independent`
選擇 `Platform Independent (Architecture Independent), Compressed TAR Archive` 下載 (mysql-connector-j-8.0.33.tar.gz)
完成下載後解壓縮，裡面有 `mysql-connector-j-8.0.33.jar` 檔案
複製檔案到 liquibase/lib directory 具體在 `/opt/homebrew/Cellar/liquibase/4.25.1/libexec/lib`
> 如何知道具體在哪裡？ 我是透過查看看 `ls -al $(command -v liquibase)` 指向的地方，然後在附近找一找可能的路徑
> ```
> lrwxr-xr-x  1 jett  admin  40 Jan 19 10:54 /opt/homebrew/bin/liquibase -> ../Cellar/liquibase/4.25.1/bin/liquibase
> ```

```shell
touch liquibase.properties changelog.xml changelog.sql changelog.yml changelog.json
```

編輯 `liquibase.properties`

```properties
changeLogFile=changelog.xml
# or `--changelog-file` args
liquibase.command.url=jdbc:mysql://127.0.0.1:3306/dbmt_liquibase
liquibase.command.username=root
liquibase.command.password=root
```

編輯 `changelog.xml`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<databaseChangeLog
    xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:ext="http://www.liquibase.org/xml/ns/dbchangelog-ext"
    xmlns:pro="http://www.liquibase.org/xml/ns/pro"
    xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
        http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-latest.xsd
        http://www.liquibase.org/xml/ns/dbchangelog-ext http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-ext.xsd
        http://www.liquibase.org/xml/ns/pro http://www.liquibase.org/xml/ns/pro/liquibase-pro-latest.xsd">

    <changeSet id="1" author="Liquibase">
        <createTable tableName="test_table">
            <column name="test_id" type="int">
                <constraints primaryKey="true"/>
            </column>
            <column name="test_column" type="varchar"/>
        </createTable>
    </changeSet>

</databaseChangeLog>
```

```shell
liquibase status
```

```
####################################################
##   _     _             _ _                      ##
##  | |   (_)           (_) |                     ##
##  | |    _  __ _ _   _ _| |__   __ _ ___  ___   ##
##  | |   | |/ _` | | | | | '_ \ / _` / __|/ _ \  ##
##  | |___| | (_| | |_| | | |_) | (_| \__ \  __/  ##
##  \_____/_|\__, |\__,_|_|_.__/ \__,_|___/\___|  ##
##              | |                               ##
##              |_|                               ##
##                                                ##
##  Get documentation at docs.liquibase.com       ##
##  Get certified courses at learn.liquibase.com  ##
##                                                ##
####################################################
Starting Liquibase at 11:44:14 (version 4.25.1 #690 built at 2023-12-18 16:29+0000)
Liquibase Version: 4.25.1
Liquibase Open Source 4.25.1 by Liquibase
ERROR: Exception Details
ERROR: Exception Primary Class:  SQLSyntaxErrorException
ERROR: Exception Primary Reason: Unknown database 'dbmt_liquibase'
ERROR: Exception Primary Source: 4.25.1

Unexpected error running Liquibase: Connection could not be created to jdbc:mysql://127.0.0.1:3306/dbmt_liquibase with driver com.mysql.cj.jdbc.Driver.  Unknown database 'dbmt_liquibase'

For more information, please use the --log-level flag
```

需要創建 database `dbmt_liquibase`
創建後重新執行 `liquibase status`

```
####################################################
##   _     _             _ _                      ##
##  | |   (_)           (_) |                     ##
##  | |    _  __ _ _   _ _| |__   __ _ ___  ___   ##
##  | |   | |/ _` | | | | | '_ \ / _` / __|/ _ \  ##
##  | |___| | (_| | |_| | | |_) | (_| \__ \  __/  ##
##  \_____/_|\__, |\__,_|_|_.__/ \__,_|___/\___|  ##
##              | |                               ##
##              |_|                               ##
##                                                ##
##  Get documentation at docs.liquibase.com       ##
##  Get certified courses at learn.liquibase.com  ##
##                                                ##
####################################################
Starting Liquibase at 12:02:55 (version 4.25.1 #690 built at 2023-12-18 16:29+0000)
Liquibase Version: 4.25.1
Liquibase Open Source 4.25.1 by Liquibase
1 changeset has not been applied to root@192.168.215.1@jdbc:mysql://127.0.0.1:3306/dbmt_liquibase
     changelog.xml::1::Liquibase
Liquibase command 'status' was executed successfully.
```

資料庫出現了 `DATABASECHANGELOG` `DATABASECHANGELOGLOCK`

Inspect the deployment SQL

```shell
liquibase update-sql
```

```
####################################################
##   _     _             _ _                      ##
##  | |   (_)           (_) |                     ##
##  | |    _  __ _ _   _ _| |__   __ _ ___  ___   ##
##  | |   | |/ _` | | | | | '_ \ / _` / __|/ _ \  ##
##  | |___| | (_| | |_| | | |_) | (_| \__ \  __/  ##
##  \_____/_|\__, |\__,_|_|_.__/ \__,_|___/\___|  ##
##              | |                               ##
##              |_|                               ##
##                                                ##
##  Get documentation at docs.liquibase.com       ##
##  Get certified courses at learn.liquibase.com  ##
##                                                ##
####################################################
Starting Liquibase at 12:39:16 (version 4.25.1 #690 built at 2023-12-18 16:29+0000)
Liquibase Version: 4.25.1
Liquibase Open Source 4.25.1 by Liquibase
--  Create Database Lock Table
CREATE TABLE dbmt_liquibase.DATABASECHANGELOGLOCK (ID INT NOT NULL, `LOCKED` TINYINT NOT NULL, LOCKGRANTED datetime NULL, LOCKEDBY VARCHAR(255) NULL, CONSTRAINT PK_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

--  Initialize Database Lock Table
DELETE FROM dbmt_liquibase.DATABASECHANGELOGLOCK;

INSERT INTO dbmt_liquibase.DATABASECHANGELOGLOCK (ID, `LOCKED`) VALUES (1, 0);

--  Lock Database
UPDATE dbmt_liquibase.DATABASECHANGELOGLOCK SET `LOCKED` = 1, LOCKEDBY = 'Jett-MBP-13-M1-2020.localdomain (192.168.1.195)', LOCKGRANTED = NOW() WHERE ID = 1 AND `LOCKED` = 0;

--  Create Database Change Log Table
CREATE TABLE dbmt_liquibase.DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, `DESCRIPTION` VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL, DEPLOYMENT_ID VARCHAR(10) NULL);

--  *********************************************************************
--  Update Database Script
--  *********************************************************************
--  Change Log: changelog.xml
--  Ran at: 2024/1/19 下午12:39
--  Against: root@192.168.215.1@jdbc:mysql://127.0.0.1:3306/dbmt_liquibase
--  Liquibase version: 4.25.1
--  *********************************************************************

--  Changeset changelog.xml::1::jett
CREATE TABLE dbmt_liquibase.user (id INT NOT NULL, name VARCHAR(255) NULL, email VARCHAR(255) NULL, CONSTRAINT PK_USER PRIMARY KEY (id));

INSERT INTO dbmt_liquibase.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'jett', 'changelog.xml', NOW(), 1, '9:7162cd97dbd3b9fd8e30c615e2fe361e', 'createTable tableName=user', '', 'EXECUTED', NULL, NULL, '4.25.1', '5639157369');

--  Release Database Lock
UPDATE dbmt_liquibase.DATABASECHANGELOGLOCK SET `LOCKED` = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

Liquibase command 'update-sql' was executed successfully.
```

make changes to your database

```shell
liquibase update
```

```
####################################################
##   _     _             _ _                      ##
##  | |   (_)           (_) |                     ##
##  | |    _  __ _ _   _ _| |__   __ _ ___  ___   ##
##  | |   | |/ _` | | | | | '_ \ / _` / __|/ _ \  ##
##  | |___| | (_| | |_| | | |_) | (_| \__ \  __/  ##
##  \_____/_|\__, |\__,_|_|_.__/ \__,_|___/\___|  ##
##              | |                               ##
##              |_|                               ##
##                                                ##
##  Get documentation at docs.liquibase.com       ##
##  Get certified courses at learn.liquibase.com  ##
##                                                ##
####################################################
Starting Liquibase at 12:39:49 (version 4.25.1 #690 built at 2023-12-18 16:29+0000)
Liquibase Version: 4.25.1
Liquibase Open Source 4.25.1 by Liquibase
Running Changeset: changelog.xml::1::jett

UPDATE SUMMARY
Run:                          1
Previously run:               0
Filtered out:                 0
-------------------------------
Total change sets:            1

Liquibase: Update has been successful. Rows affected: 1
Liquibase command 'update' was executed successfully.
```

新增 change set

```xml
<changeSet id="2" author="jett">
    <addColumn tableName="user">
        <column name="age" type="int"/>
    </addColumn>
</changeSet>
```

執行 liquibase update-sql 查看會執行的 sql
執行 liquibase update 變更資料庫
