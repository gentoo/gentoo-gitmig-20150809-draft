# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnapster/gnapster-1.5.0-r1.ebuild,v 1.2 2001/10/07 16:38:23 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A napster client for GTK/GNOME"
SRC_URI="http://jasta.gotlinux.org/files/${P}.tar.gz"
HOMEPAGE="http://jasta.gotlinux.org/gnapster.html"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
                 >=media-libs/gdk-pixbuf-0.11.0-r1 )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf"--disable-nls"
    	fi

	if [ -z "`use gnome`" ]
    	then
      		myconf="${myconf} --disable-gnome"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    ${myconf} || die

	emake || die
}

src_install () {
	make prefix=${D}/usr 						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING README* TODO NEWS
}

