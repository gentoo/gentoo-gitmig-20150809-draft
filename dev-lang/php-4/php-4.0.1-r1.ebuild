# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php-4/php-4.0.1-r1.ebuild,v 1.3 2000/09/15 20:08:47 drobbins Exp $

P=php-4.0.1
A="php-4.0.1.tar.gz number4.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="HTML embedded scripting language"
SRC_URI="http://www.php.net/distributions/php-4.0.1.tar.gz
	 http://www.php.net/extra/number4.tar.gz"
HOMEPAGE="http://www.php.net/"

src_compile() {

#    FLAGS="-mpentium -march=pentium -O4 -I/usr/include/freetype"
#    export CFLAGS=$FLAGS
#    export CPPFLAGS=$FLAGS
#    export CXXFLAGS=$FLAGS
    export LD_FLAGS="$LD_FLAGS -ltiff -ljpeg -L/usr/X11R6/lib"
    try ./configure --with-mysql=yes --enable-safe-mode \
	--enable-sysvsem --enable-sysvshm --with-zlib=yes --enable-bcmath \
	--with-readline --with-gettext --enable-calendar --with-ldap\
	--with-gd --with-ttf --with-jpeg-dir=/usr/lib \
	--with-config-file-path=`/usr/sbin/apxs -q SYSCONFDIR` \
	--with-apxs="/usr/sbin/apxs -ltiff" --with-exec-dir="/usr/lib/apache/bin" \
	--enable-versioning --enable-inline-optimization --enable-trans-sid
    try make
}

src_unpack() {
    unpack php-4.0.1.tar.gz
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

pkg_postinst() {

  . ${ROOT}/etc/rc.d/config/functions

  # Activate PHP-Extension in httpd.conf
  einfo "Activate PHP in httpd.conf..."
  cp ${ROOT}/etc/httpd/httpd.conf ${ROOT}/etc/httpd/httpd.conf.orig
  sed -e "s/^#LoadModule php4_module/LoadModule php4_module/" \
      -e "s/^#AddModule mod_php4.c/AddModule mod_php4.c/" \
      -e "s/#AddType application\/x-httpd-php /AddType application\/x-httpd-php /" \
      -e "s/#AddType application\/x-httpd-php-/AddType application\/x-httpd-php-/" \
	${ROOT}/etc/httpd/httpd.conf.orig > ${ROOT}/etc/httpd/httpd.conf

}
