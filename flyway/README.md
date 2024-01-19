# flyway

## install flyway cli

```shell
brew install flyway
```

## get start

`flyway.toml`

```toml
[flyway]
locations = ["filesystem:migrations"]


[environments.default]
locations = ["filesystem:migrations"]
url = "jdbc:mysql://127.0.0.1:3306/dbmt_flyway"
user = "root"
password = "root"
```

`migrations/V1__Create_person_table.sql`

```sql
create table PERSON
(
    ID   int          not null,
    NAME varchar(100) not null
);
```

```
flyway migrate
```

```
Flyway OSS Edition 10.6.0 by Redgate

See release notes here: https://rd.gt/416ObMi
ERROR: Skipping filesystem location: migrations (not found)
ERROR: Unable to obtain connection from database (jdbc:mysql://127.0.0.1:3306/dbmt_flyway) for user 'root': Could not connect to address=(host=127.0.0.1)(port=3306)(type=master) : (conn=680) Unknown database 'dbmt_flyway'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SQL State  : 42000
Error Code : 1049
Message    : Could not connect to address=(host=127.0.0.1)(port=3306)(type=master) : (conn=680) Unknown database 'dbmt_flyway'

Caused by: java.sql.SQLSyntaxErrorException: Could not connect to address=(host=127.0.0.1)(port=3306)(type=master) : (conn=680) Unknown database 'dbmt_flyway'
Caused by: java.sql.SQLSyntaxErrorException: (conn=680) Unknown database 'dbmt_flyway'
```

需要手動建立 `dbmt_flyway` database

建立完成後才能執行 flyway migrate

```
Flyway OSS Edition 10.6.0 by Redgate

See release notes here: https://rd.gt/416ObMi
Database: jdbc:mysql://127.0.0.1:3306/dbmt_flyway (MySQL 8.0)
Schema history table `dbmt_flyway`.`flyway_schema_history` does not exist yet
Successfully validated 1 migration (execution time 00:00.011s)
Creating Schema History table `dbmt_flyway`.`flyway_schema_history` ...
Current version of schema `dbmt_flyway`: << Empty Schema >>
Migrating schema `dbmt_flyway` to version "1 - Create person table"
Successfully applied 1 migration to schema `dbmt_flyway`, now at version v1 (execution time 00:00.009s)
```

`migrations/V2__Add_column_to_person.sql`

```sql
alter table PERSON
    add column AGE int;
```

```
flyway info
```

```
Flyway OSS Edition 10.6.0 by Redgate

See release notes here: https://rd.gt/416ObMi
Database: jdbc:mysql://127.0.0.1:3306/dbmt_flyway (MySQL 8.0)
Schema version: 1

+-----------+---------+----------------------+------+---------------------+---------+----------+
| Category  | Version | Description          | Type | Installed On        | State   | Undoable |
+-----------+---------+----------------------+------+---------------------+---------+----------+
| Versioned | 1       | Create person table  | SQL  | 2024-01-19 02:22:31 | Success | No       |
| Versioned | 2       | Add column to person | SQL  |                     | Pending | No       |
+-----------+---------+----------------------+------+---------------------+---------+----------+
```

```
flyway migrate
```

```
Flyway OSS Edition 10.6.0 by Redgate

See release notes here: https://rd.gt/416ObMi
Database: jdbc:mysql://127.0.0.1:3306/dbmt_flyway (MySQL 8.0)
Successfully validated 2 migrations (execution time 00:00.019s)
Current version of schema `dbmt_flyway`: 1
Migrating schema `dbmt_flyway` to version "2 - Add column to person"
Successfully applied 1 migration to schema `dbmt_flyway`, now at version v2 (execution time 00:00.040s)
```

flyway 沒辦法 undo 因為 undo 功能是付費版的 `flyway team`
