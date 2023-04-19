# User テーブル

|  id  |  user_name  |  email  |  password_digest  |
| ---- | ---- | ---- | ---- |
|  integer  |  string  |  string  |  string  |


# Task テーブル

|  id  |  user_id(FK)  |  title  |  content  |
| ---- | ---- | ---- | ---- |
|  integer  |  integer  |  string  |  text  |


# Stick (中間)テーブル

|  id  |  task_id(FK)  |  label_id(FK)  |
| ---- | ---- | ---- |
|  integer  |  integer  |  integer  |


# Labelテーブル

|  id  |  lbl_name  |
| ---- | ---- |
|  integer  |  string  |