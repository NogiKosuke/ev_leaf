# User テーブル

|  id  |  user_name  |  email  |  password_digest  |
| ---- | ---- | ---- | ---- |
|  integer  |  string  |  string  |  string  |


# Task テーブル

|  id  |  user_id(FK)  |  title  |  content  |
| ---- | ---- | ---- | ---- |
|  integer  |  integer  |  string  |  text  |


# Stick (中間)テーブル

|  id  |  task_id(FK)  |  lavel_id(FK)  |
| ---- | ---- | ---- |
|  integer  |  integer  |  integer  |


# Lavelテーブル

|  id  |  lvl_name  |
| ---- | ---- |
|  integer  |  string  |