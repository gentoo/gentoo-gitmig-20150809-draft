# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-1.4.0.4-r1.ebuild,v 1.1 2001/10/06 10:47:27 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-applets"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	 >=gnome-base/libgtop-1.0.12-r1
	 >=gnome-base/libghttp-1.0.9-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
        >=app-text/scrollkeeper-0.2
        >=dev-util/xml-i18n-tools-0.8.4"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
	            --sysconfdir=/etc					\
		    ${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
