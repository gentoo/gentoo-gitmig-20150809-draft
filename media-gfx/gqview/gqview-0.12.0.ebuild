# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>

S=${WORKDIR}/${P}
DESCRIPTION="A GNOME image browser"
SRC_URI="http://download.sourceforge.net/gqview/${P}.tar.gz"
HOMEPAGE="http://gqview.sourceforge.net/"

DEPEND="virtual/glibc
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=x11-libs/gtk+-1.2.10-r4
	nls? ( sys-devel/gettext )"


src_compile() {

	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --prefix=/usr				\
		--mandir=/usr/share/man				\
		--infodir=/usr/share/info			\
		--sysconfdir=/etc				\
		--host=${CHOST}					\
		${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr					\
		mandir=${D}/usr/share/man			\
		infodir=${D}/usr/share/info			\
		sysconfdir=${D}/etc				\
		GNOME_DATADIR=${D}/usr/share			\
		install || die
	
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}

