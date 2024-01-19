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

driver support

|           | MySQL | PostgreSQL |
|-----------|-------|------------|
| liquibase | ✅     | ✅          |
| flyway    | ✅     | ✅          |
| dbmate    | ✅     | ✅          |
| prisma    | ✅     | ✅          |

migration file coding style

|           | SQL | XML | JSON | YAML | Prisma Schema |
|-----------|-----|-----|------|------|---------------|
| liquibase | ✅   | ✅   | ✅    | ✅    | ❌             |
| flyway    | ✅   | ❌   | ❌    | ❌    | ❌             |
| dbmate    | ✅   | ❌   | ❌    | ❌    | ❌             |
| prisma    | ✅   | ❌   | ❌    | ❌    | ✅             |

management style

|           | Imperative 命令式 | Declarative 宣告式 |
|-----------|----------------|-----------------|
| liquibase | ✅              | ❌               |
| flyway    | ✅              | ❌               |
| dbmate    | ✅              | ❌               |
| prisma    | ✅              | ✅               |

database GUI

|           | database GUI |
|-----------|--------------|
| liquibase | ❌            |
| flyway    | ❌            |
| dbmate    | ❌            |
| prisma    | ✅            |
