# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php/php-4.1.2-r7.ebuild,v 1.2 2002/04/16 00:55:05 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTML embedded scripting language"
SRC_URI="http://www.php.net/distributions/${P}.tar.gz"
HOMEPAGE="http://www.php.net/"
SLOT="0"

DEPEND="virtual/glibc
	>=dev-libs/gmp-3.1.1
	~media-libs/freetype-1.3.1
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.2.1
	>=media-libs/libgd-1.8.3
	>=media-libs/t1lib-1.0.1
	>=net-www/apache-1.3.24-r1
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
	crypt? ( >=dev-libs/libmcrypt-2.4 )
	X? ( virtual/x11 )
	qt? ( =x11-libs/qt-2.3* )
	xml? ( >=app-text/sablotron-0.44 )
	libwww? ( >=net-libs/libwww-5.3.2 )
	imap? ( >=net-mail/uw-imap-2001a-r1 )
	flash? ( media-libs/libswf media-libs/ming )
	xml2? ( dev-libs/libxml2 )
	java? ( virtual/jdk )
	pdflib? ( >=media-libs/pdflib-4.0.1-r2 )"

RDEPEND="virtual/glibc
	>=dev-libs/gmp-3.1.1
	~media-libs/freetype-1.3.1
	>=media-libs/jpeg-6b
 	>=media-libs/libpng-1.0.7
 	>=media-libs/t1lib-1.0.1
	>=net-www/apache-1.3.24-r1
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
	pdflib? ( >=media-libs/pdflib-4.0.1-r2 )
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
		if [ "$JAVAC" ];
		then
	              cp ext/java/Makefile.in ext/java/Makefile.in.orig
	              cat ext/java/Makefile.in.orig | \
	                      sed -e "s/^\tjavac/\t\$(JAVAC)/" \
	                      > ext/java/Makefile.in
		fi
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
	use pdflib && myconf="$myconf --with-pdflib"

	if [ "`use qt`" ] ; then
		export QTDIR=/usr/qt/2 #hope this helps - danarmak
		myconf="$myconf --with-qtdom" 
	fi

	if [ "`use imap`" ] ; then
		if [ "`use ssl`" ] && [ "`strings ${ROOT}/usr/lib/c-client.a \
					| grep ssl_onceonlyinit`" ] ; then
			echo "Compiling imap with SSL support"
			myconf="$myconf --with-imap --with-imap-ssl"
		else
			echo "Compiling imap without SSL support"
			myconf="$myconf --with-imap"
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
	use crypt && myconf="$myconf --with-mcrypt"
	use java && myconf="$myconf --with-java=${JDK_HOME}"

	LDFLAGS="$LDFLAGS -ltiff -ljpeg"

	if [ "`use X`" ] ; then
		myconf="$myconf --with-xpm-dir=/usr/X11R6"
		LDFLAGS="$LDFLAGS -L/usr/X11R6/lib"
	fi
    
	./configure \
		--prefix=/usr \
		--with-gd \
		--with-gmp \
		--with-ttf \
		--enable-ftp \
		--with-t1lib \
		--enable-dbase \
		--with-zlib=yes \
		--enable-bcmath \
		--enable-sysvsem \
		--enable-sysvshm \
		--enable-calendar \
		--enable-trans-sid \
		--enable-safe-mode \
		--enable-versioning \
		--enable-track-vars \
		--with-png-dir=/usr/lib \
		--with-jpeg-dir=/usr/lib \
		--enable-inline-optimization \
		--with-apxs="/usr/sbin/apxs -ltiff" \
		--with-exec-dir="/usr/lib/apache/bin" \
		--with-config-file-path=`/usr/sbin/apxs -q SYSCONFDIR` \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	make || die "compile problem"
}


src_install() {
 	make INSTALL_ROOT=${D} install-pear || die

	dodoc CODING_STANDARDS LICENSE EXTENSIONS 
	dodoc RELEASE_PROCESS README.* TODO NEWS
	dodoc ChangeLog* *.txt

	exeinto /usr/lib/apache-extramodules
	doexe .libs/libphp4.so

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/mod_php.conf
	newins php.ini-dist php.ini
	dosym /etc/apache/conf/addon-modules/php.ini /etc/apache/conf/php.ini
}

pkg_postinst() {
	einfo
	einfo "Execute ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/libphp4.so mod_php4.c php4_module \
		before=perl define=PHP4 addconf=conf/addon-modules/mod_php.conf
	:;
}
