# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vde/vde-1.5.7.ebuild,v 1.3 2010/10/28 09:39:29 ssuominen Exp $

DESCRIPTION="vde is a virtual distributed ethernet emulator for emulators like qemu, bochs, and uml."
SRC_URI="mirror://sourceforge/vde/${P}.tgz"
HOMEPAGE="http://vde.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=""

src_compile() {
	mv Makefile Makefile.1
	sed -e 's/ $(BIN_DIR)/ $(DESTDIR)$(BIN_DIR)/' <Makefile.1      >Makefile
	cat Makefile
	cd vdetaplib
	mv Makefile Makefile.1
	sed -e 's/ $(BIN_DIR)/ $(DESTDIR)$(BIN_DIR)/' -e 's/ $(LIB_DIR)/ $(DESTDIR)$(LIB_DIR)/' <Makefile.1      >Makefile
	cd ..
	cd doc
	mv Makefile Makefile.1
	sed -e 's/ $(MAN_DIR)/ $(DESTDIR)$(MAN_DIR)/'  <Makefile.1      >Makefile
	cd ..
	BIN_DIR=/usr/bin LIB_DIR=/usr/lib MAN_DIR=/usr/man emake || die
}

src_install() {

	BIN_DIR=/usr/bin LIB_DIR=/usr/lib MAN_DIR=/usr/man make DESTDIR=${D} install || die

	dodoc INSTALL PORTS README
}
