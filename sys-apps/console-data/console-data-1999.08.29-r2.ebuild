# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-data/console-data-1999.08.29-r2.ebuild,v 1.7 2002/08/14 04:40:34 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Data (fonts, keymaps) for the consoletools package"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/keyboards/${P}.tar.gz"
HOMEPAGE="http://altern.org/ydirson/en/lct/data.html"
KEYWORDS="x86 ppc sparc sparc64"
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

