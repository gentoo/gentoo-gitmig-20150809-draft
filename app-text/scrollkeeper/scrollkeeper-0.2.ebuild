# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/scrollkeeper/scrollkeeper-0.2.ebuild,v 1.7 2001/10/06 10:06:49 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Scrollkeeper"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=dev-libs/libxml-1.8.11
 	 >=sys-libs/zlib-1.1.3"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local  myconf

	if [ -z "`use nls`" ] ; then
		myconf ="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr                                       \
	            --sysconfdir=/etc					\
		    --localstatedir=/var $myconf || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
