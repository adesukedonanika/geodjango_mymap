インストーラ
http://download.osgeo.org/osgeo4w/osgeo4w-setup-x86_64.exe


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



続いて先ほど作成したデータベースの管理ユーザを作成します。
以下のコマンドではgeo_adminという管理ユーザを作成して、geodjangodbデータベースに対してフル権限を付与しています。

CREATE USER geo_admin WITH PASSWORD 'geoadmin';
#### CREATE ROLE
GRANT ALL PRIVILEGES ON DATABASE geodjangodb TO geo_admin;
#### GRANT


# setting.py　変更

データベース
DATABASES = {		
    'default': {		
        'ENGINE': 'django.contrib.gis.db.backends.postgis',		
        'NAME': 'geodjangodb',		
        'USER': 'geo_admin',		
        'PASSWORD': 'geoadmin',		
        'HOST': 'localhost',		
        'PORT':'',		
    }		

タイムゾーン
LANGUAGE_CODE = 'ja'

TIME_ZONE = 'Asia/Tokyo'


INSTALLED_APPSにmapアプリケーションとGISを追加します。

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
　  'django.contrib.gis',   #追加
    'map.apps.MapConfig',   #追加
]



python manage.py makemigrations

django.core.exceptions.ImproperlyConfigured: Could not find the GDAL library (tried "gdal302", "gdal301", "gdal300", "gdal204", "gdal203", "gdal202", "gdal201", "gdal20"). Is GDAL installed? If it is, try setting GDAL_LIBRARY_PATH in your settings.