# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php-4/php-4.0.1_p2-r1.ebuild,v 1.1 2000/08/16 15:08:41 achim Exp $

P=php-4.0.1pl2
A="${P}.tar.gz number4.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="HTML embedded scripting language"
SRC_URI="http://www.php.net/distributions/${P}.tar.gz
	 http://www.php.net/extra/number4.tar.gz"
HOMEPAGE="http://www.php.net/"

src_compile() {

    export LD_FLAGS="$LD_FLAGS -ltiff -ljpeg -L/usr/X11R6/lib"
    ./configure --with-mysql=yes --enable-safe-mode \
	--enable-sysvsem --enable-sysvshm --with-zlib=yes --enable-bcmath \
	--with-readline --with-gettext --enable-calendar --with-ldap\
	--with-gd --with-ttf --with-t1lib --with-jpeg-dir=/usr/lib \
	--with-config-file-path=`/usr/sbin/apxs -q SYSCONFDIR` \
	--with-apxs="/usr/sbin/apxs -ltiff" --with-exec-dir="/usr/lib/apache/bin" \
	--enable-versioning --enable-inline-optimization --enable-trans-sid --enable-track-vars
    make
}

src_unpack() {
    unpack php-4.0.1pl2.tar.gz
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
  dodoc CODING_STANDARDS FUNCTION_LIST.txt INSTALL LICENSE
  dodoc MAINTAINERS MODULES_STATUS README.* TODO NEWS
}

pkg_config() {

  . ${ROOT}/etc/rc.d/config/functions

  if [ -f "${ROOT}/etc/httpd/httpd.conf" ]
  then

    # Activate PHP-Extension in httpd.conf
    einfo "Activate PHP in httpd.conf..."
    cp ${ROOT}/etc/httpd/httpd.conf ${ROOT}/etc/httpd/httpd.conf.orig
    sed -e "s/^#LoadModule php4_module/LoadModule php4_module/" \
      -e "s/^#AddModule mod_php4.c/AddModule mod_php4.c/" \
      -e "s/#AddType application\/x-httpd-php /AddType application\/x-httpd-php /" \
      -e "s/#AddType application\/x-httpd-php-/AddType application\/x-httpd-php-/" \
	${ROOT}/etc/httpd/httpd.conf.orig > ${ROOT}/etc/httpd/httpd.conf

  fi
}


