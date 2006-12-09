# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ftnchek/ftnchek-3.3.1.ebuild,v 1.2 2006/12/09 09:57:18 masterdriverz Exp $

DESCRIPTION="Static analyzer a la 'lint' for Fortran 77"
HOMEPAGE="http://www.dsm.fordham.edu/~ftnchek/"
SRC_URI="http://www.dsm.fordham.edu/~${PN}/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i -e 's:-$(STRIP) $(bindir)/ftnchek$(EXE)::' Makefile.in || die 'sed failed'
}

src_install() {
	einstall || die 'einstall failed'
	dodoc FAQ INSTALL LICENSE PATCHES README ToDo
	dohtml html/*
	dodir /usr/share/${PN}
	cp -r test ${D}/usr/share/${PN}
}
