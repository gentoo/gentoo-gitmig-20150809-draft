# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>, Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/evolution/evolution-0.15-r1.ebuild,v 1.3 2001/10/06 16:10:21 azarah Exp $

DB3=db-3.1.17
A="${P}.tar.gz ${DB3}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.ximian.com/pub/source/${PN}/${A}
	 ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
	 http://www.sleepycat.com/update/3.1.17/${DB3}.tar.gz"
HOMEPAGE="http://www.ximian.com"

# Fixed bonobo-conf, gal, gtkhtml order as specified in Evolution README 
# (really needed?)
DEPEND=">=gnome-libs/bonobo-conf-0.11
        >=gnome-base/bonobo-1.0.9-r1
	>=gnome-base/gal-0.13-r1
        >=gnome-extra/gconf-1.0.4-r1
	>=gnome-base/gtkhtml-0.14-r1
	>=gnome-base/oaf-0.6.6-r1
	>=gnome-base/ORBit-0.5.10-r1
	>=gnome-base/libglade-0.17-r1
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=dev-libs/libxml-1.8.15
	>=gnome-base/gnome-vfs-1.0.2-r1
	>=gnome-base/gnome-print-0.20
	>=app-text/scrollkeeper-0.2
        >=dev-util/xml-i18n-tools-0.8.4
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	mozilla? ( >=net-www/mozilla-0.9.4-r2 )
	pda? ( >=gnome-apps/gnome-pilot-0.1.61 )" 

src_compile() {
	cd ${WORKDIR}/${DB3}/build_unix
	../dist/configure --prefix=${WORKDIR}/db3 || die
	make || die # make -j 4 doesn't work, use make
	make prefix=${WORKDIR}/db3 install || die

	cd ${S}
  
	local myconf

	MOZILLA=$MOZILLA_FIVE_HOME

	if [ "`use ssl`" ] ; then
		myconf="$myconf --enable-ssl"
	else
		myconf="$myconf --disable-ssl"
	fi

	if [ "`use pda`" ] ; then
		myconf="$myconf --with-pisock=/usr --enable-pilot-conduits=yes"
	fi

	if [ "`use mozilla`" ] ; then
		myconf="$myconf --with-nspr-includes=${MOZILLA}/include/nspr \
				--with-nss-includes=${MOZILLA}/include       \
				--with-nspr-libs=${MOZILLA}"
	fi

	./configure --prefix=/opt/gnome --host=${CHOST} 		     \
		    --sysconfdir=/etc/opt/gnome 			     \
		    --enable-file-locking=no 				     \
		    --with-db3=${WORKDIR}/db3 				     \
	            --without-movemail 					     \
		    --enable-nntp $myconf || die

	make || die # emake didn't work.
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
	dodoc NEWS README
}


