-- migrate:up

alter table users add age int not null after name;

-- migrate:down

alter table users drop age;
