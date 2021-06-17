
管理者として実行
psql -U postgres -l
パスワード: postgres

Power shell ポリシー有効化
PowerShell -ExecutionPolicy RemoteSigned  scripts/activate.ps1


createdb -U postgres -E UTF-8 geodjangodb



psql -U postgres -d postgres

postgresユーザーでログインする
db一覧を表示
\l



psql -U postgres -d geodjangodb -c "CREATE EXTENSION postgis;"
ユーザー postgres のパスワード:postgres
CREATE EXTENSION


CREATE USER geo_admin WITH PASSWORD 'geoadmin';
#### CREATE ROLE
GRANT ALL PRIVILEGES ON DATABASE geodjangodb TO geo_admin;
#### GRANT

