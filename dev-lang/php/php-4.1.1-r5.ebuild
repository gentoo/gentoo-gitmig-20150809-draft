# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php/php-4.1.1-r5.ebuild,v 1.2 2002/04/12 15:51:45 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTML embedded scripting language"
SRC_URI="http://www.php.net/distributions/${P}.tar.gz"
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
	nls? ( sys-devel/gettext )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	berkdb? ( >=sys-libs/db-3 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1 )
	mhash? ( >=app-crypt/mhash-0.8 )
	mcrypt? ( >=dev-libs/libmcrypt-2.4 )
	X? ( virtual/x11 )
	qt? ( =x11-libs/qt-2.3* )
	xml? ( >=app-text/sablotron-0.44 )
	libwww? ( >=net-libs/libwww-5.3.2 )
	imap? ( virtual/imapUW )
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
	java? ( virtual/jdk )
	"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	if [ "`use java`" ] ; then

		cp configure configure.orig
		cat configure.orig | \
			sed -e 's/LIBS="-lttf $LIBS"/LIBS="-lttf -lhpi $LIBS"/' \
			> configure

		cp ext/gd/gd.c ext/gd/gd.c.orig
		cat ext/gd/gd.c.orig | \
			sed -e "s/typedef FILE gdIOCtx;//" \
			> ext/gd/gd.c
	fi
}

src_compile() {

	local myconf

	# readline can only be used w/ CGI build, so I'll turn it off
	#if [ "`use readline`" ] ; then
	#  myconf="--with-readline"
	#fi
	# also, t1lib support seems to be broken: gcc: /usr/lib/.libs/libt1.so: No such file or directory

	myconf="--without-readline --without-t1lib"
	use pam && myconf="$myconf --with-pam"
	use nls && myconf="$myconf --with-gettext"
	use gdbm && myconf="$myconf --with-gdbm=/usr"
	use berkdb && myconf="$myconf --with-db3=/usr"
	use mysql && myconf="$myconf --with-mysql=/usr"
	use postgres && myconf="$myconf --with-pgsql=/usr"
	use odbc && myconf="$myconf --with-unixODBC=/usr"
	use ldap &&  myconf="$myconf --with-ldap" 

	if [ "`use qt`" ] ; then
		EXPORT QTDIR=/usr/qt/2 #hope this helps - danarmak
		myconf="$myconf --with-qtdom" 
	fi

	if [ "`use imap`" ] ; then
		# need to see if imap was built w/ ssl support
		local pkg=`tail -n 1 /var/db/pkg/virtual/imapUW/VIRTUAL`
		if [ "`grep ssl /var/db/pkg/${pkg}/USE`" ] ; then
			echo "imap compiled with SSL"
			myconf="$myconf --with-imap-ssl"
		else
			echo "imap compiled w/o SSL"
			myconf="$myconf --with-imap"
			# php build will fail if imap doesn't have SSL support
			echo "unfortunately, the php build will fail due to"
			echo "strange header errors in /usr/include/imap4r1.h"
			echo "Please rebuild uw-imap or pine w/ 'ssl' in USE"
			die
		fi
	fi
	use libwww && myconf="$myconf --with-xml" || myconf="$myconf --disable-xml"
	use flash && myconf="$myconf --with-swf=/usr --with-ming=/usr"

	if [ "`use xml`" ] ; then
		export LIBS="-lxmlparse -lxmltok"
		myconf="$myconf --with-sablot=/usr"
	fi

	use xml2 && myconf="$myconf --with-dom"
	use mhash && myconf="$myconf --with-mhash"
	use mcrypt && myconf="$myconf --with-mcrypt"
	use java && myconf="$myconf --with-java=${JDK_HOME}"

	LDFLAGS="$LDFLAGS -ltiff -ljpeg"

	if [ "`use X`" ] ; then
		myconf="$myconf --with-xpm-dir=/usr/X11R6"
		LDFLAGS="$LDFLAGS -L/usr/X11R6/lib"
	fi
    
	./configure --enable-safe-mode --enable-ftp --enable-track-vars --with-gmp \
		--enable-dbase --enable-sysvsem --enable-sysvshm --with-zlib=yes --enable-bcmath \
		--enable-calendar --enable-versioning --enable-inline-optimization --enable-trans-sid \
		--with-gd --with-ttf --with-t1lib --with-png-lib=/usr/lib --with-jpeg-dir=/usr/lib --prefix=/usr \
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



