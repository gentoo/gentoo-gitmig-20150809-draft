# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtktalog/gtktalog-0.99.12.ebuild,v 1.2 2001/10/06 23:01:24 hallski Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="The GTK disk catalog."
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${A}"
HOMEPAGE="http://gtktalog.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=sys-libs/zlib-1.1.3
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
        	myconf="--disable-nls"
	fi
    
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
	            --enable-htmltitle					\
		    --enable-mp3info					\
		    --enable-aviinfo 					\
	            --enable-mpeginfo					\
		    --enable-modinfo					\
		    --enable-catalog2					\
                    --enable-catalog3					\
		    $myconf || die

	emake || die
}

src_install () {
 	# DESTDIR does not work for mo-files

	make prefix=${D}/usr sysconfdir=${D}/etc install || die

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO
}
