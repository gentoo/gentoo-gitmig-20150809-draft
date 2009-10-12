# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ftnchek/ftnchek-3.2.2.ebuild,v 1.7 2009/10/12 19:14:37 ssuominen Exp $

DESCRIPTION="Static analyzer a la 'lint' for Fortran 77"
HOMEPAGE="http://www.dsm.fordham.edu/~ftnchek/"
SRC_URI="http://www.dsm.fordham.edu/~${PN}/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

src_install() {
	einstall || die
	dodoc FAQ PATCHES README ToDo
	dohtml html/*
	dodir /usr/share/${PN}
	cp -r test "${D}"/usr/share/${PN}
}
