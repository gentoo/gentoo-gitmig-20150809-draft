# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-1.2.3.ebuild,v 1.4 2001/10/06 21:44:08 hallski Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="gnome-media"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-media/"${A}
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
        >=app-text/scrollkeeper-0.2
        nls? ( sys-devel/gettext )"


src_compile() {                           
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	if [ "`use alsa`"  ] ; then
		myconf="--enable-alsa=yes"
	else
		myconf="--enable-alsa=no"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --with-ncurses $myconf || die

	emake || die
}

src_install() {                               
	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}

