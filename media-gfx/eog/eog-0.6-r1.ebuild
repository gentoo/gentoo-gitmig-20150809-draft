# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-0.6-r1.ebuild,v 1.2 2001/10/06 20:15:36 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Eye of GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/eog/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/eog.shtml"

RDEPEND="virtual/glibc
        >=gnome-base/gconf-1.0.4-r2
        >=gnome-base/bonobo-1.0.9-r1"

DEPEND="${RDEPEND}
	virtual/glibc
	nls? ( sys-devel/gettext )
        >=dev-util/xml-i18n-tools-0.8.4"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    $myconf || die
	
	emake || die
}

src_install() {
	make DESTDIR=${D} 						\
	     GCONG_CONFIG_SOURCE=xml=${D}/etc/gconf/gconf.xml.defaults 	\
	     install || die

	dodoc AUTHORS COPYING DEPENDS ChangeLog HACKING NEWS README 	\
	      TODO MAINTAINERS
}







