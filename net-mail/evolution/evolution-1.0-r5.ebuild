# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>, Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/evolution/evolution-1.0-r5.ebuild,v 1.3 2002/02/04 14:18:10 g2boojum Exp $

DB3=db-3.1.17
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.ximian.com/pub/source/${PN}/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz
	 http://people.codefactory.se/~micke/${PN}/${P}.tar.gz
	 http://www.sleepycat.com/update/3.1.17/${DB3}.tar.gz"
HOMEPAGE="http://www.ximian.com"

DEPEND=">=gnome-extra/bonobo-conf-0.14
        >=gnome-base/bonobo-1.0.15
	>=gnome-extra/gal-0.18.1
        >=gnome-base/gconf-1.0.7
	>=gnome-extra/gtkhtml-1.0.0
	>=gnome-base/oaf-0.6.6-r1
	>=gnome-base/ORBit-0.5.10-r1
	>=gnome-base/libglade-0.17-r1
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=dev-libs/libxml-1.8.16
	>=gnome-base/gnome-vfs-1.0.2-r1
	>=gnome-base/gnome-print-0.30
	>=app-text/scrollkeeper-0.2
        >=dev-util/intltool-0.11
	ssl?     ( >=net-www/mozilla-0.9.6-r3 )
	ldap?    ( >=net-nds/openldap-2.0 )
	mozilla? ( >=net-www/mozilla-0.9.6-r3 )
	pda?     ( >=gnome-extra/gnome-pilot-0.1.61-r2 )" 


src_compile() {

	cd ${WORKDIR}/${DB3}/build_unix
	../dist/configure --prefix=${WORKDIR}/db3 || die
	make || die # make -j 4 doesn't work, use make
	make prefix=${WORKDIR}/db3 install || die

	cd ${S}
  
	local myconf=""

	MOZILLA=$MOZILLA_FIVE_HOME

	if [ "`use pda`" ] ; then
		myconf="${myconf} --with-pisock=/usr --enable-pilot-conduits=yes"
	else
		myconf="${myconf} --enable-pilot-conduits=no"
	fi

	if [ "`use ldap`" ] ; then
		myconf="${myconf} --with-openldap=yes"
	else
		myconf="${myconf} --with-openldap=no"
	fi

	if [ "`use mozilla`" ] ; then
		myconf="${myconf} --with-nspr-includes=${MOZILLA}/include/nspr \
			        --with-nspr-libs=${MOZILLA}"
	else
		myconf="${myconf} --without-nspr-libs --without-nspr-includes"
	fi

	if [ "`use ssl`" ] ; then
		myconf="${myconf} --with-nss-includes=${MOZILLA}/include/nss   \
				--with-nss-libs=${MOZILLA}"
	else
		myconf="${myconf} --without-nss-libs --without-nss-includes"
	fi

	# SSL needs NSPR libs  ...
	if [ "`use ssl`" ] && [ -z "`use mozilla`" ] ; then
		myconf="${myconf} --with-nspr-includes=${MOZILLA}/include/nspr \
				--with-nspr-libs=${MOZILLA}"
	fi

	CFLAGS="${CFLAGS} -I/usr/include/libpisock"
	./configure --host=${CHOST} 		     			\
		    --prefix=/usr					\
		    --sysconfdir=/etc		 			\
		    --localstatedir=/var/lib				\
		    --enable-file-locking=no 				\
		    --with-db3=${WORKDIR}/db3 				\
		    ${myconf} || die

	# emake might not work, so fall back to make
	emake || make || die
}

src_install() {

	# Use DESTDIR // Hallski
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
	dodoc NEWS README
}

