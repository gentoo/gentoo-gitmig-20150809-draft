# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php/php-4.0.6-r4.ebuild,v 1.1 2002/02/12 17:44:44 karltk Exp $

A=${PN}-4.0.6.tar.gz
S=${WORKDIR}/${PN}-4.0.6
DESCRIPTION="HTML embedded scripting language"
SRC_URI="http://www.php.net/distributions/${A}"
HOMEPAGE="http://www.php.net/"

DEPEND="virtual/glibc
	>=dev-libs/gmp-3.1.1
	~media-libs/freetype-1.3.1
	>=media-libs/jpeg-6b
        >=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
        >=media-libs/libgd-1.8.3
	>=media-libs/t1lib-1.0.1
	>=net-www/apache-1.3
	pam? ( >=sys-libs/pam-0.75 )
	readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 )
	gettext? ( sys-devel/gettext )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	berkdb? ( >=sys-libs/db-3 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1 )
	X? ( virtual/x11 )
	qt? ( =x11-libs/qt-2.3* )
	xml? ( >=app-text/sablotron-0.44 )
	libwww? ( >=net-libs/libwww-5.3.2 )
	imap? ( virtual/imap )
	flash? ( media-libs/libswf media-libs/ming )
	xml2? ( dev-libs/libxml2 )
	java? ( virtual/jdk )
	"

RDEPEND="virtual/glibc
	>=dev-libs/gmp-3.1.1
	~media-libs/freetype-1.3.1
	>=media-libs/jpeg-6b
 	>=media-libs/libpng-1.0.7
 	>=media-libs/t1lib-1.0.1
	>=net-www/apache-1.3
	pam? ( >=sys-libs/pam-0.75 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	berkdb? ( >=sys-libs/db-3 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1 )
	X? ( virtual/x11 )
	qt? ( >=x11-libs/qt-2.3.0 )
	xml? ( >=app-text/sablotron-0.44 )
	libwww? ( >=net-libs/libwww-5.3.2 )
	xml2? ( dev-libs/libxml2 )
	imap? ( virtual/imap )
	java? ( virtual/jdk )
	"

src_compile() {

	local myconf

	use readline && myconf="${myconf} --with-readline"
	use pam && myconf="${myconf} --with-pam"
	use gettext && myconf="${myconf} --with-gettext"
	use gdbm && myconf="${myconf} --with-gdbm=/usr"
	use berkdb && myconf="${myconf} --with-db3=/usr"
	use mysql && myconf="${myconf} --with-mysql=/usr"
	use postgres && myconf="${myconf} --with-pgsql=/usr"
	use odbc && myconf="${myconf} --with-unixODBC=/usr"
	use ldap && myconf="${myconf} --with-ldap"
	use imap && myconf="${myconf} --with-imap"
	
	if [ "`use qt`" ] ; then
		EXPORT QTDIR=/usr/qt/2 #hope this helps - danarmak
		myconf="$myconf --with-qtdom" 
	fi
	
	use libwww && myconf="${myconf} --with-xml" || myconf="${myconf} --disable-xml"
	use flash && myconf="${myconf} --with-swf=/usr --with-ming=/usr"
	
	if [ "`use xml`" ] ; then
		export LIBS="-lxmlparse -lxmltok"
		myconf="$myconf --with-sablot=/usr"
	fi

	use xml2 && myconf="${myconf} --with-dom"
	use java && myconf="${myconf} --with-java=${JDK_HOME}"

	LDFLAGS="$LDFLAGS -ltiff -ljpeg"

	if [ "`use X`" ] ; then
		myconf="$myconf --with-xpm-dir=/usr/X11R6"
		LDFLAGS="$LDFLAGS -L/usr/X11R6/lib"
	fi
    

    
	./configure --enable-safe-mode --enable-ftp --enable-track-vars --with-gmp \
		--enable-dbase --enable-sysvsem --enable-sysvshm --with-zlib=yes --enable-bcmath \
		--enable-calendar --enable-versioning --enable-inline-optimization --enable-trans-sid \
		--with-gd --with-ttf --with-t1lib --with-jpeg-dir=/usr/lib --prefix=/usr \
		--with-config-file-path=`/usr/sbin/apxs -q SYSCONFDIR` --host=${CHOST} \
		--with-apxs="/usr/sbin/apxs -ltiff" --with-exec-dir="/usr/lib/apache/bin" $myconf || die

	make || die
}


src_install() {                 
 
	make INSTALL_ROOT=${D} install-pear || die
	dodir /usr/lib/apache
	cp .libs/libphp4.so ${D}/usr/lib/apache

	dodir /etc/httpd
	cp php.ini-dist ${D}/etc/httpd/php.ini
	dodoc CODING_STANDARDS LICENSE EXTENSIONS 
	dodoc RELEASE_PROCESS README.* TODO NEWS
	dodoc ChangeLog* *.txt
}

pkg_config() {

	. ${ROOT}/etc/rc.d/config/functions

	if [ -f "${ROOT}/etc/httpd/httpd.conf" ] ; then

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



