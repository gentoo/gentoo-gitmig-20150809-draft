# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-data/console-data-1999.08.29-r3.ebuild,v 1.1 2002/09/06 07:16:16 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Data (fonts, keymaps) for the consoletools package"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/keyboards/${P}.tar.gz
	http://ftp.debian.org/debian/pool/main/c/${PN}/${PN}_${PV}-24.diff.gz"
HOMEPAGE="http://lct.sourceforge.net/data.html"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	zcat ${DISTDIR}/${PN}_${PV}-24.diff.gz | patch -p1
}

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

