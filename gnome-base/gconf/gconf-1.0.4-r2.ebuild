# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.0.4-r2.ebuild,v 1.1 2001/10/06 10:47:27 hallski Exp $

P=GConf-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gconf"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/GConf/${A}"

HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=sys-libs/db-3.2.3h
        >=gnome-base/oaf-0.6.6-r1
	>=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
        >=dev-util/guile-1.4"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    ${myconf} || die

	make || die   # Doesn't work with -j 4 (hallski)
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
