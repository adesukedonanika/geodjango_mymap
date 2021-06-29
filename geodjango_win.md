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


(geodjango_env) PS C:\Users\adesu\OneDrive\Developper\geodjango> psql -U postgres -d geodjangodb -c "CREATE EXTENSION postgis;"
ユーザー postgres のパスワード:
ERROR:  ライブラリ"C:/Program Files/PostgreSQL/10/lib/rtpostgis-2.4.dll"をロードできませんでした: %1 is not a valid Win32 application.

<!-- エラー対処 -->
<!-- https://stackoverflow.com/questions/57510486/error-adding-postgis-extension-to-postgresql-win10 -->

Copy-Item -Path "C:\Program Files\PostgreSQL\10\bin\postgisgui\ssleay32.dll" -Destination "C:\Program Files\PostgreSQL\10\bin\ssleay32.dll"

Copy-Item -Path "C:\Program Files\PostgreSQL\10\bin\postgisgui\libeay32.dll" -Destination "C:\Program Files\PostgreSQL\10\bin\libeay32.dll"

(geodjango_env) PS C:\Users\adesu\OneDrive\Developper\geodjango> psql -U postgres -d geodjangodb -c "CREATE EXTENSION postgis;"
ユーザー postgres のパスワード:
CREATE EXTENSION
(geodjango_env) PS C:\Users\adesu\OneDrive\Developper\geodjango>

<!-- エクステンションの生成確認 -->
psql -U postgres -d geodjangodb
select * from pg_available_extensions;

 <!-- pointcloud                   | 1.1.0           |                   | data type for lidar point clouds
 pointcloud_postgis           | 1.0             |                   | integration for pointcloud LIDAR data and PostGIS geometry data
 postgis                      | 2.4.4           | 2.4.4             | PostGIS geometry, geography, and raster spatial types and functions
 postgis_sfcgal               | 2.4.4           |                   | PostGIS SFCGAL functions
 postgis_tiger_geocoder       | 2.4.4           |                   | PostGIS tiger geocoder and reverse geocoder
 postgis_topology             | 2.4.4           |                   | PostGIS topology spatial types and functions
 postgres_fdw                 | 1.0             |                   | foreign-data wrapper for remote PostgreSQL servers
 refint                       | 1.0             |                   | functions for implementing referential integrity (obsolete)
 seg                          | 1.1             |                   | data type for representing line segments or floating-point intervals
 sslinfo                      | 1.2             |                   | information about SSL certificates
 tablefunc                    | 1.0             |                   | functions that manipulate whole tables, including crosstab
 tcn                          | 1.0             |                   | Triggered change notifications
 test_ext1                    | 1.0             |                   | Test extension 1
-- More  -- -->



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



setup