# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Reviewed by Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-1.4.0.3.ebuild,v 1.5 2001/10/06 21:48:20 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-utils"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
         >=dev-util/guile-1.4
	 >=media-libs/gdk-pixbuf-0.11.0-r1"

DEPEND="${RDEPEND}
        >=app-text/scrollkeeper-0.2
        nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --with-ncurses $myconf || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}



