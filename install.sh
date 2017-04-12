#!/usr/bin/env bash

# Works fine on Debian

NGINX_VERSION="1.9.9"
NCHAN_VERSION="0.97"
HEADERS_MORE_VERSION="0.29"
DEV_KIT_VERSION="0.2.19"
ECHO_VERSION="0.58"
FANCY_INDEX_VERSION="0.3.5"
DAV_EXT_VERSION="0.0.3"
CACHE_PURGE_VERSION="2.3"
AUTH_PAM_VERSION="1.4"
LUA_VERSION="0.10.0"
UPLOAD_PROGRESS_VERSION="0.9.1"
SUBSTITUTIONS_VERSION="0.6.4"
GOOGLE_FILTER_VERSION="0.2.0"

CURRENT_DIR=$PWD

apt-get update -qq

# PCRE library
apt-get install -y libpcre3 libpcre3-dev

# PERL
apt-get install -y libperl-dev

# C++ Compiler
apt-get install -y build-essential

# Open SSL
apt-get install -y openssl libssl-dev

# XML XSLT
apt-get install -y libxslt-dev

# GD
apt-get install -y libgd-dev

# GeoIP
apt-get install -y libgeoip-dev

# LUA
apt-get install -y lua5.2 liblua5.2-dev libluajit-5.1-dev

# PAM
apt-get install -y libpam-dev

# Build package
apt-get install -y checkinstall

src_url="http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz"
echo -e 'Downloading Nginx...'
curl -L "$src_url" | tar xz

src_url="https://github.com/slact/nchan/archive/v${NCHAN_VERSION}.tar.gz"
echo -e 'Downloading Nchan Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERS_MORE_VERSION}.tar.gz"
echo -e 'Downloading Headers Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/simpl/ngx_devel_kit/archive/v${DEV_KIT_VERSION}.tar.gz"
echo -e 'Downloading Dev Kit Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/openresty/echo-nginx-module/archive/v${ECHO_VERSION}.tar.gz"
echo -e 'Downloading Echo Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/aperezdc/ngx-fancyindex/archive/v${FANCY_INDEX_VERSION}.tar.gz"
echo -e 'Downloading Fancy Index Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/arut/nginx-dav-ext-module/archive/v${DAV_EXT_VERSION}.tar.gz"
echo -e 'Downloading Dav Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/FRiCKLE/ngx_cache_purge/archive/${CACHE_PURGE_VERSION}.tar.gz"
echo -e 'Downloading Cache Purge Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/stogh/ngx_http_auth_pam_module/archive/v${AUTH_PAM_VERSION}.tar.gz"
echo -e 'Downloading Auth Pam Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/openresty/lua-nginx-module/archive/v${LUA_VERSION}.tar.gz"
echo -e 'Downloading Lua Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/masterzen/nginx-upload-progress-module/archive/v${UPLOAD_PROGRESS_VERSION}.tar.gz"
echo -e 'Downloading Upload Progress Module...'
curl -L "$src_url" | tar xz

src_url="https://github.com/cuber/ngx_http_google_filter_module/archive/${GOOGLE_FILTER_VERSION}.tar.gz"
echo -e 'Downloading Nginx Module for Google...'
curl -L "$src_url" | tar xz

src_url="https://github.com/yaoweibin/ngx_http_substitutions_filter_module/archive/v${SUBSTITUTIONS_VERSION}.tar.gz"
echo -e 'Downloading Substitutions Filter Module...'
curl -L "$src_url" | tar xz



cd "nginx-${NGINX_VERSION}"

./configure \
--with-cc-opt="-g -O2 -fstack-protector--param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2" \
--with-ld-opt="-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--as-needed" \
--prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--user=nginx \
--group=nginx \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_image_filter_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-http_mp4_module \
--with-http_perl_module \
--with-http_random_index_module \
--with-http_xslt_module \
--with-http_geoip_module \
--with-mail \
--with-mail_ssl_module \
--with-file-aio \
--with-http_v2_module \
--with-ipv6 \
--with-threads \
--with-stream \
--with-stream_ssl_module \
--with-http_slice_module \
--with-debug \
--with-pcre-jit \
--add-module="${CURRENT_DIR}/nchan-${NCHAN_VERSION}" \
--add-module="${CURRENT_DIR}/headers-more-nginx-module-${HEADERS_MORE_VERSION}" \
--add-module="${CURRENT_DIR}/ngx_devel_kit-${DEV_KIT_VERSION}" \
--add-module="${CURRENT_DIR}/echo-nginx-module-${ECHO_VERSION}" \
--add-module="${CURRENT_DIR}/ngx-fancyindex-${FANCY_INDEX_VERSION}" \
--add-module="${CURRENT_DIR}/nginx-dav-ext-module-${DAV_EXT_VERSION}" \
--add-module="${CURRENT_DIR}/ngx_cache_purge-${CACHE_PURGE_VERSION}" \
--add-module="${CURRENT_DIR}/ngx_http_auth_pam_module-${AUTH_PAM_VERSION}" \
--add-module="${CURRENT_DIR}/lua-nginx-module-${LUA_VERSION}" \
--add-module="${CURRENT_DIR}/nginx-upload-progress-module-${UPLOAD_PROGRESS_VERSION}" \
--add-module="${CURRENT_DIR}/ngx_http_google_filter_module-${GOOGLE_FILTER_VERSION}" \
--add-module="${CURRENT_DIR}/ngx_http_substitutions_filter_module-${SUBSTITUTIONS_VERSION}"  && make

useradd --no-create-home nginx

mkdir -p /var/log/nginx/
chown nginx:nginx /var/log/nginx/

mkdir -p /var/cache/nginx/{client_temp,proxy_temp,fastcgi_temp,uwsgi_temp,scgi_temp}
chown nginx:nginx /var/lib/nginx/

# Install
checkinstall -D make install

echo $(nginx -v)
echo $(sudo nginx -t)

# Echo
echo -e "Create init script."
echo -e "Example: https://github.com/regorDam/nginx-install"
echo -e ""
echo -e "Use: 'netstat -tnlp | grep nginx' for check status"
