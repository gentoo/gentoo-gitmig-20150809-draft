# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/evolution/evolution-1.2.4.ebuild,v 1.4 2003/04/28 23:46:44 liquidx Exp $

IUSE="ssl nls mozilla ldap doc spell pda ipv6 kerberos kde"

#provide Xmake and Xemake

inherit eutils flag-o-matic gnome.org libtool virtualx

DB3="db-3.1.17"
S="${WORKDIR}/${P}"
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.ximian.com/pub/ximian-evolution/source/${P}.tar.gz
	http://www.sleepycat.com/update/snapshot/${DB3}.tar.gz"
HOMEPAGE="http://www.ximian.com"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

RDEPEND="app-text/scrollkeeper
	>=gnome-extra/bonobo-conf-0.16
	>=gnome-base/bonobo-1.0.21
	>=gnome-base/gnome-common-1.2
	>=gnome-extra/gal-0.24
	=gnome-base/gconf-1.0*
	>=gnome-extra/gtkhtml-1.1.10
	>=gnome-base/oaf-0.6.10
	>=gnome-base/ORBit-0.5.12
	<gnome-base/libglade-2.0		
	>=media-libs/gdk-pixbuf-0.18.0
	>=dev-libs/libxml-1.8.17
	=gnome-base/gnome-vfs-1.0*		
	>=gnome-base/gnome-print-0.35
	=dev-util/gob-1*
	>=net-libs/soup-0.7.11
	doc?	 ( >=app-text/scrollkeeper-0.3.10-r1 )
	ssl? ( mozilla? ( >=net-www/mozilla-0.9.9 ) : ( >=dev-libs/openssl-0.9.5 ) )
	ldap?    ( >=net-nds/openldap-2.0 )
	pda?     ( >=gnome-extra/gnome-pilot-0.1.61-r2
			>=dev-libs/pilot-link-0.11.5 )
	spell?   ( >=app-text/gnome-spell-0.5 )
	kerberos? ( app-crypt/krb5 )"

# the pilot-link dep is normally covered by gnome-pilot, but evo
# requires an higher version then gnome-pilot (bug #10307)

# Added dependency on "dev-util/gob" this should fix a configure bug

DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.4.1-r1
	doc? ( dev-util/gtk-doc )
	nls?  ( >=dev-util/intltool-0.20
	        sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	
	cd ${S};
	# Mandrake patches
	epatch ${FILESDIR}/${PN}-1.1.90-kde.patch
	epatch ${FILESDIR}/${PN}-1.1.90-subversion.patch
	epatch ${FILESDIR}/${PN}-1.1.90-sharedldap.patch
	
	# libtoolize to fix not all libs installing, and buggy .la files.
	# also add the gnome-pilot.m4 to the macros directory to fix
	# problems with the pilot conduct
	cd ${S}; cp -f ltmain.sh ${S}/libical/
	elibtoolize --reverse-deps
	aclocal -I macros -I /usr/share/aclocal/gnome-macros
	autoconf
	automake --add-missing
	
	(cd libical ; aclocal -I /usr/share/aclocal/gnome-macros ; autoconf)

	# Fix sandbox errors
	cd ${S}/default_user
	cp Makefile.in Makefile.in.orig
	sed -e 's:-mkdir $(defaultdir:-mkdir $(DESTDIR)$(defaultdir:g' \
		Makefile.in.orig > Makefile.in
}

src_compile() {

	# *************************************************************
	#
	#   DB3 compile...
	#
	# *************************************************************

	# Rather ugly hack to make sure pthread mutex support are not enabled ...
	cd ${WORKDIR}/${DB3}/dist
#	cp configure configure.orig
#	awk '!/MUTEX.*THREADS/ { sub("mut_pthread", "mut_fcntl"); print }' \
#		configure.orig > configure
	
	einfo "Compiling DB3..."
	cd ${WORKDIR}/${DB3}/build_unix
	../dist/configure --prefix=${WORKDIR}/db3 || die

	if [ "`egrep "^LIBS=[[:space:]]*-lpthread" Makefile`" ]
	then
		append-flags "-pthread"
	fi

	make || die
	make prefix=${WORKDIR}/db3 install || die

	# *************************************************************
	#
	#   Evolution compile...
	#
	# *************************************************************

	einfo "Compiling Evolution..."
	cd ${S}
  
	local myconf=""
	local MOZILLA="${MOZILLA_FIVE_HOME}"

	if [ -n "`use pda`" ] ; then
		myconf="${myconf} --with-pisock=/usr --enable-pilot-conduits=yes"
	else
		myconf="${myconf} --enable-pilot-conduits=no"
	fi

	if [ -n "`use ldap`" ] ; then
		myconf="${myconf} --with-openldap=yes --with-static-ldap=no"
	else
		myconf="${myconf} --with-openldap=no"
	fi
	
	if [ -n "`use kerberos`" ]; then
		myconf="${myconf} --with-krb5=/usr --with-krb4=/usr"
	else
		myconf="${myconf} --with-krb5=no --with-krb4=no"
	fi

	# Use Mozilla NSS libs if 'mozilla' *and* 'ssl' in USE
	if [ -n "`use ssl`" -a -n "`use mozilla`" ] ; then
		myconf="${myconf} --enable-nss=yes \
			--with-nspr-includes=${MOZILLA}/include/nspr \
			--with-nspr-libs=${MOZILLA} \
			--with-nss-includes=${MOZILLA}/include/nss \
			--with-nss-libs=${MOZILLA}"
	else
		myconf="${myconf} --without-nspr-libs --without-nspr-includes \
			--without-nss-libs --without-nss-includes"
	fi

	# Else use OpenSSL if 'mozilla' not in USE  ...
	if [ -n "`use ssl`" -a -z "`use mozilla`" ] ; then
		myconf="${myconf} --enable-openssl=yes"
	fi

	if [ -n "`use doc`" ] ; then
		myconf="${myconf} --enable-gtk-doc"
	else
		myconf="${myconf} --disable-gtk-doc"
	fi

	if [ -n "`use ipv6`" ] ; then
		myconf="${myconf} --enable-ipv6=yes"
	else
		myconf="${myconf} --enable-ipv6=no"
	fi

	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
	fi

	CFLAGS="${CFLAGS} -I/usr/include/libpisock"
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--with-db3=${WORKDIR}/db3 \
		--disable-python-bindings \
		${myconf} || die

	# fix xml-i18n-merge UTF-8 problems
	export LANG="C"
    
	#needs to be able to connect to X display to build.
	Xemake || Xmake || die
}

src_install() {
	cd omf-install
	cp Makefile Makefile.old
	sed -e "s:scrollkeeper-update.*::g" Makefile.old > Makefile
	rm Makefile.old
	cd ${S}

	# Install with $DESTDIR, as in some rare cases $D gets hardcoded
	# into the binaries (seems like a ccache problem at present),
	# because everything is recompiled with the "new" PREFIX, if
	# $DESTDIR is _not_ used.
	make DESTDIR=${D} \
		prefix=/usr \
		mandir=/usr/share/man \
		infodir=/usr/share/info \
		datadir=/usr/share \
		sysconfdir=/etc \
		localstatedir=/var/lib \
		KDE_APPLNK_DIR=/usr/share/applnk \
		install || die

	# remove kde link if USE="-kde"
	if [ -z "`use kde`" ]; then
		rm -rf ${D}/usr/share/applnk
	fi

	dodoc AUTHORS COPYING* ChangeLog HACKING MAINTAINERS
	dodoc NEWS README
}

pkg_postinst() {
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update >/dev/null 2>&1
}

pkg_postrm() {
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update >/dev/null 2>&1
}

