# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php-4/php-4.0.3_p1.ebuild,v 1.3 2000/11/02 02:17:12 achim Exp $

P=php-4.0.3pl1
A="${P}.tar.gz number4.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="HTML embedded scripting language"
SRC_URI="http://www.php.net/distributions/${P}.tar.gz
	 http://www.php.net/extra/number4.tar.gz"
HOMEPAGE="http://www.php.net/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72
	>=media-libs/freetype-1.3.1
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	>=media-libs/t1lib-1.0.1
	>=net-www/apache-ssl-1.3
	>=dev-db/mysql-3.23.26
	>=net-nds/openldap-1.2.11
	>=x11-base/xfree-4.0.1"

src_compile() {

    export LD_FLAGS="$LD_FLAGS -ltiff -ljpeg -L/usr/X11R6/lib"
    ./configure --with-mysql=/usr --enable-safe-mode \
	--enable-sysvsem --enable-sysvshm --with-zlib=yes --enable-bcmath \
	--with-readline --with-gettext --enable-calendar --with-ldap\
	--with-gd --with-ttf --with-t1lib --with-jpeg-dir=/usr/lib \
	--with-config-file-path=`/usr/sbin/apxs -q SYSCONFDIR` \
	--with-apxs="/usr/sbin/apxs -ltiff" --with-exec-dir="/usr/lib/apache/bin" \
	--enable-versioning --enable-inline-optimization --enable-trans-sid \
	--with-xpm-dir=/usr/X11R6 --enable-track-vars
    try make
}

src_unpack() {
    unpack php-4.0.3pl1.tar.gz
    cd ${S}
    unpack number4.tar.gz
}

src_install() {                 
  cd ${S}
  dodir /usr/lib/apache
  cp .libs/libphp4.so ${D}/usr/lib/apache
  dodir /etc/httpd
  cp php.ini-dist ${D}/etc/httpd/php.ini
  into /usr
  dodoc CODING_STANDARDS FUNCTION_LIST.txt LICENSE
  dodoc README.* TODO NEWS
}

pkg_config() {

  . ${ROOT}/etc/rc.d/config/functions

  if [ -f "${ROOT}/etc/httpd/httpd.conf" ]
  then

    # Activate PHP-Extension in httpd.conf
    echo "Activate PHP in httpd.conf..."
    cp ${ROOT}/etc/httpd/httpd.conf ${ROOT}/etc/httpd/httpd.conf.orig
    sed -e "s/^#LoadModule php4_module/LoadModule php4_module/" \
      -e "s/^#AddModule mod_php4.c/AddModule mod_php4.c/" \
      -e "s/#AddType application\/x-httpd-php /AddType application\/x-httpd-php /" \
      -e "s/#AddType application\/x-httpd-php-/AddType application\/x-httpd-php-/" \
	${ROOT}/etc/httpd/httpd.conf.orig > ${ROOT}/etc/httpd/httpd.conf

  fi
}



