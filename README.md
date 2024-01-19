- framework
    - django (python)
    - typeorm (nodejs)
    - laravel (php)
- independent of framework
    - liquibase https://www.liquibase.org/
    - flyway https://flywaydb.org/
    - dbmate https://github.com/amacneil/dbmate
    - prisma https://www.prisma.io/

# framework-agnostic overview

✅ replace OO
❌ replace XX

driver support

|           | MySQL | PostgreSQL |
|-----------|-------|------------|
| liquibase | OO    | OO         |
| flyway    | OO    | OO         |
| dbmate    | OO    | OO         |
| prisma    | OO    | OO         |

migration file coding style

|           | SQL | XML | JSON | YAML | Prisma Schema |
|-----------|-----|-----|------|------|---------------|
| liquibase | OO  | OO  | OO   | OO   | XX            |
| flyway    | OO  | XX  | XX   | XX   | XX            |
| dbmate    | OO  | XX  | XX   | XX   | XX            |
| prisma    | OO  | XX  | XX   | XX   | OO            |

management style

|           | Imperative 命令式 | Declarative 宣告式 |
|-----------|----------------|-----------------|
| liquibase | OO             | XX              |
| flyway    | OO             | XX              |
| dbmate    | OO             | XX              |
| prisma    | OO             | OO              |

database GUI

|           | database GUI |
|-----------|--------------|
| liquibase | XX           |
| flyway    | XX           |
| dbmate    | XX           |
| prisma    | OO           |
