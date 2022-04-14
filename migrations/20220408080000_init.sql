DROP SCHEMA ecobenchmark CASCADE;
CREATE SCHEMA ecobenchmark;

SET search_path TO ecobenchmark;

CREATE TABLE users
(
    id            uuid primary key,
    login         text,
    creation_date timestamp
);

CREATE INDEX idx_users_creation_date
    ON users(creation_date);

CREATE TABLE list
(
    id            uuid primary key,
    name          text,
    creation_date timestamp
);

CREATE INDEX idx_list_creation_date
    ON list(creation_date);

CREATE TABLE task
(
    id            uuid primary key,
    list_id       uuid references ecobenchmark.list,
    name          text,
    description   text,
    creation_date timestamp
);

CREATE INDEX idx_task_list_id
    ON task(list_id);

CREATE INDEX idx_task_creation_date
    ON task(creation_date);