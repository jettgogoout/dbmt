# dbmate

## install dbmate cli

```shell
cd dbmate
curl -fsSL -o ./dbmate https://github.com/amacneil/dbmate/releases/latest/download/dbmate-macos-arm64
chmod +x ./dbmate
```

## get start

1. config .env file

   ```dotenv
   #DATABASE_URL="mysql://username:password@127.0.0.1:3306/database_name"
   DATABASE_URL="mysql://root:root@127.0.0.1:3306/dbmt_dbmate"
   ```

2. create migration file

   run this command
   ```shell
   ./dbmate new create_users_table
   ```
   output
   ```
   Creating migration: db/migrations/20240118080415_create_users_table.sql
   ```

3. write migration use raw SQL

   ```sql
   -- migrate:up
   create table users
   (
       id    integer,
       name  varchar(255),
       email varchar(255) not null
   );

   -- migrate:down
   drop table users;
   ```

4. run first migration

   ```shell
   ./dbmate up
   ```
   output
   ```
   Creating: dbmt_dbmate
   Applying: 20240118080415_create_users_table.sql
   ```
   如果 database 不存在的話，會自動建立 database `dbmt_dbmate`
   依照 `-- migrate:up` 內容運行
   並且建立 `schema_migrations` table 紀錄已經運行的版本，可以透過參數 `DBMATE_MIGRATIONS_TABLE` 修改名稱
   如果資料庫支持 transaction，預設為 true，可以透過 key:value 方式新增選項 `-- migrate:up transaction:false`

   ```shell
   ./dbmate down
   ```
   output
   ```
   Rolling back: 20240118080415_create_users_table.sql
   ```
   按照 `-- migrate:down` 內容運行

5. run second migration

   run this command
   ```shell
   ./dbmate new add_columns_to_user_table
   ```
   output
   ```
   Creating migration: db/migrations/20240118084959_add_columns_to_user_table.sql
   ```
   check status
   ```shell
   ./dbmate status
   ```
   output
   ```
   [X] 20240118080415_create_users_table.sql
   [ ] 20240118084959_add_columns_to_user_table.sql

   Applied: 1
   Pending: 1
   ```
