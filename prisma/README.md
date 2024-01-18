# prisma

## install prisma cli

node.js minimum required version: 16.13 / 18.X / 20.X

```shell
cd prisma
npm install prisma --save-dev
npx prisma version
# or ./node_modules/.bin/prisma version
```

output

```
prisma                  : 5.8.1
@prisma/client          : Not found
Computed binaryTarget   : darwin-arm64
Operating System        : darwin
Architecture            : arm64
Node.js                 : v16.20.2
Query Engine (Node-API) : libquery-engine 78caf6feeaed953168c64e15a249c3e9a033ebe2 (at node_modules/@prisma/engines/libquery_engine-darwin-arm64.dylib.node)
Schema Engine           : schema-engine-cli 78caf6feeaed953168c64e15a249c3e9a033ebe2 (at node_modules/@prisma/engines/schema-engine-darwin-arm64)
Schema Wasm             : @prisma/prisma-schema-wasm 5.8.1-1.78caf6feeaed953168c64e15a249c3e9a033ebe2
Default Engines Hash    : 78caf6feeaed953168c64e15a249c3e9a033ebe2
Studio                  : 0.497.0
```

## get start

1. init prisma

   ```shell
   npx prisma init --datasource-provider mysql
   ```
   output
   ```
   ✔ Your Prisma schema was created at prisma/schema.prisma
   You can now open it in your favorite editor.

   warn You already have a .gitignore file. Don't forget to add `.env` in it to not commit any private information.

   Next steps:
   1. Set the DATABASE_URL in the .env file to point to your existing database. If your database has no tables yet, read https://pris.ly/d/getting-started
   2. Run prisma db pull to turn your database schema into a Prisma schema.
   3. Run prisma generate to generate the Prisma Client. You can then start querying your database.

   More information in our documentation:
   https://pris.ly/d/getting-started
   ```
   執行完指令後，產生了 `.env` 與 `prisma/schema.prisma`，內容如下
   ```prisma
   generator client {
     provider = "prisma-client-js"
   }

   datasource db {
     provider = "mysql"
     url      = env("DATABASE_URL")
   }
   ```

   ```dotenv
   DATABASE_URL="mysql://johndoe:randompassword@localhost:3306/mydb"
   ```

   generator 目前用不到，可以先移除（generator 是 node js 的 db client library）

2. config .env file

   ```dotenv
   DATABASE_URL="mysql://root:root@127.0.0.1:3306/dbmt_prisma"
   ```

3. write migration use Prisma Schema

   ```prisma
   model user {
      id    Int    @id @default(autoincrement())
      name  String // varchar(191)
      email String @db.VarChar(255)
   }
   ```

4. run first migration

   ```shell
   npx prisma migrate dev --name init
   ```
   output
   ```
   Environment variables loaded from .env
   Prisma schema loaded from prisma/schema.prisma
   Datasource "db": MySQL database "dbmt_prisma" at "127.0.0.1:3306"

   Applying migration `20240118145912_init`

   The following migration(s) have been created and applied from new schema changes:

   migrations/
     └─ 20240118145912_init/
       └─ migration.sql

   Your database is now in sync with your schema.
   ```
   如果 database 不存在的話，會自動建立 database `dbmt_prisma`
   prisma migrate 有一些 subcommand
    - dev (Create a migration from changes in Prisma schema, apply it to the database)
        - `--name` (Name the migration)
        - `--create-only` (Create a new migration but do not apply it. The migration will be empty if there are no
          changes in Prisma schema)
    - deploy (Apply pending migrations to the database)
    - status (Check the status of your database migrations)

5. run second migration

   ```prisma
   model user {
     id    Int    @id @default(autoincrement())
     name  String
     age   Int // <<-- new columns
     email String @db.VarChar(255)
   }
   ```

   ```shell
   npx prisma migrate dev --name add-columns-to-user-table
   ```
   output
   ```
   Environment variables loaded from .env
   Prisma schema loaded from prisma/schema.prisma
   Datasource "db": MySQL database "dbmt_prisma" at "127.0.0.1:3306"

   Applying migration `20240118150443_add_columns_to_user_table`

   The following migration(s) have been created and applied from new schema changes:

   migrations/
     └─ 20240118150443_add_columns_to_user_table/
       └─ migration.sql

   Your database is now in sync with your schema.
   ```
