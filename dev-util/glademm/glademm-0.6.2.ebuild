# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="A C++ backend for glade, the GUI designer for Gtk."
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

DEPEND=">=dev-util/glade-0.6.2"

RDEPEND="=x11-libs/gtk+-1.2*
	 >=x11-libs/gtkmm-1.2.5-r1
	 >=dev-util/glade-0.6.2
	 >=gnome-extra/gnomemm-1.2.0-r1"


src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info				\
		    --sysconfdir=/etc || die

	emake || die
}

src_install () {
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     sysconfdir=${D}/etc					\
	     install || die

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc docs/*.txt docs/glade.wishlist
	docinto html
	dodoc docs/*.html
}
