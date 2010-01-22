# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ftnchek/ftnchek-3.2.2.ebuild,v 1.8 2010/01/22 12:08:22 cla Exp $

DESCRIPTION="Static analyzer a la 'lint' for Fortran 77"
HOMEPAGE="http://www.dsm.fordham.edu/~ftnchek/"
SRC_URI="http://www.dsm.fordham.edu/~${PN}/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -r -e 's/CFLAGS([[:space:]]+)=/CFLAGS\1+=/' \
		-i Makefile.in || die 'sed failed'
}

src_install() {
	einstall || die
	dodoc FAQ PATCHES README ToDo
	dohtml html/*
	dodir /usr/share/${PN}
	cp -r test "${D}"/usr/share/${PN}
}
