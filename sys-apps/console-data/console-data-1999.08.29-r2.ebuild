# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-data/console-data-1999.08.29-r2.ebuild,v 1.14 2003/06/21 21:19:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Data (fonts, keymaps) for the consoletools package"
SRC_URI="mirror://sourceforge/lct/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://lct.sourceforge.net/data.html"
KEYWORDS="x86 amd64 ppc sparc ~alpha mips"
SLOT="0"
LICENSE="GPL-2"

src_compile() {

	./configure --host=${CHOST} \
		--prefix=/usr || die
	# do not use pmake
	make || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc ChangeLog
	docinto txt
	dodoc doc/README.*
	docinto txt/fonts
	dodoc doc/fonts/*
	docinto txt/keymaps
	dodoc doc/keymaps/*
}

