# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-4.2.0.ebuild,v 1.3 2002/07/17 03:26:54 rphillips Exp $

S=${WORKDIR}/php-${PV}
DESCRIPTION="PHP embedded scripting language (Commandline Use) - 
			 usable in shell scripts and crontabs"
SRC_URI="http://www.php.net/distributions/php-${PV}.tar.gz"
HOMEPAGE="http://www.php.net/"
SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="PHP"

DEPEND=">=dev-libs/gmp-3.1.1
	~media-libs/freetype-1.3.1
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.2.1
	>=media-libs/libgd-1.8.3
	>=media-libs/t1lib-1.0.1
	X? ( virtual/x11 )
	qt? ( =x11-libs/qt-2.3* )
	nls? ( sys-devel/gettext )
	pam? ( >=sys-libs/pam-0.75 )
	xml? ( >=app-text/sablotron-0.44 )
	imap? ( >=net-mail/uw-imap-2001a-r1 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	java? ( virtual/jdk )
	ldap? ( >=net-nds/openldap-1.2.11 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	xml2? ( dev-libs/libxml2 )
	crypt? ( >=dev-libs/libmcrypt-2.4
		>=app-crypt/mhash-0.8 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	flash? ( media-libs/libswf media-libs/ming )
	berkdb? ( >=sys-libs/db-3 )
	libwww? ( >=net-libs/libwww-5.3.2 )
	pdflib? ( >=media-libs/pdflib-4.0.1-r2 )
	postgres? ( >=dev-db/postgresql-7.1 )
	readline? ( >=sys-libs/ncurses-5.1
		>=sys-libs/readline-4.1 )"

RDEPEND="${DEPEND}
	qt? ( >=x11-libs/qt-2.3.0 )
	xml? ( >=app-text/sablotron-0.44 )"

src_unpack() {
	unpack php-${PV}.tar.gz
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

	# t1lib support seems to be broken: gcc: /usr/lib/.libs/libt1.so: No such file or directory

	myconf="--without-t1lib"
	use readline && myconf="${myconf} --with-readline"
	use pam && myconf="${myconf} --with-pam"
	use nls || myconf="${myconf} --without-gettext"
	use gdbm && myconf="${myconf} --with-gdbm=/usr"
	use berkdb && myconf="${myconf} --with-db3=/usr"
	use mysql && myconf="${myconf} --with-mysql=/usr"
	use postgres && myconf="${myconf} --with-pgsql=/usr"
	use odbc && myconf="${myconf} --with-unixODBC=/usr"
	use ldap &&  myconf="${myconf} --with-ldap" 
	use pdflib && myconf="${myconf} --with-pdflib"

	use qt && ( \
		export QTDIR=/usr/qt/2 #hope this helps - danarmak
		myconf="${myconf} --with-qtdom" 
	)

	if [ "`use imap`" ] ; then
		if [ "`use ssl`" ] && [ "`strings ${ROOT}/usr/lib/c-client.a \
					| grep ssl_onceonlyinit`" ] ; then
			echo "Compiling imap with SSL support"
			myconf="${myconf} --with-imap --with-imap-ssl"
		else
			echo "Compiling imap without SSL support"
			myconf="${myconf} --with-imap"
		fi
	fi
	use libwww && myconf="${myconf} --with-xml" || myconf="${myconf} --disable-xml"
	use flash && myconf="${myconf} --with-swf=/usr --with-ming=/usr"

	if [ "`use xml`" ] ; then
		export LIBS="-lxmlparse -lxmltok"
		myconf="${myconf} --with-sablot=/usr"
	fi

	use xml2 && myconf="${myconf} --with-dom"
	use crypt && myconf="${myconf} --with-mcrypt --with-mhash"
	use java && myconf="${myconf} --with-java=${JDK_HOME}"

	LDFLAGS="$LDFLAGS -ltiff -ljpeg"

	if [ "`use X`" ] ; then
		myconf="${myconf} --with-xpm-dir=/usr/X11R6"
		LDFLAGS="$LDFLAGS -L/usr/X11R6/lib"
	fi
    
	./configure \
		--prefix=/usr \
		--with-gd \
		--with-gmp \
		--with-ttf \
		--enable-ftp \
		--enable-dbase \
		--with-zlib=yes \
		--enable-bcmath \
		--enable-sysvsem \
		--enable-sysvshm \
		--enable-calendar \
		--enable-trans-sid \
		--enable-versioning \
		--enable-track-vars \
		--with-png-dir=/usr/lib \
		--with-jpeg-dir=/usr/lib \
		--enable-inline-optimization \
		--with-config-file-path=/etc/apache/conf/addon-modules || die "bad ./configure"

	make || die "compile problem"
}


src_install() {
 	make INSTALL_ROOT=${D} install-pear || die

	dodoc CODING_STANDARDS LICENSE EXTENSIONS 
	dodoc RELEASE_PROCESS README.* TODO NEWS
	dodoc ChangeLog* *.txt

	exeinto /usr/bin
	doexe php

	insinto /etc/apache/conf/addon-modules
	newins php.ini-dist php.ini
	dosym /etc/apache/conf/addon-modules/php.ini /etc/apache/conf/php.ini
}

pkg_postinst () {

	einfo "Please don't use this package on a webserver."
	einfo "There is no security compiled in."

}
