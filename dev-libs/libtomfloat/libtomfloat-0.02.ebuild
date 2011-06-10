# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomfloat/libtomfloat-0.02.ebuild,v 1.8 2011/06/10 01:08:00 radhermit Exp $

inherit toolchain-funcs

DESCRIPTION="library for floating point number manipulation"
HOMEPAGE="http://libtom.org/"
SRC_URI="http://libtom.org/files/ltf-${PV}.tar.bz2"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/libtommath"
RDEPEND=""

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc changes.txt *.pdf WARNING
	docinto demos ; dodoc demos/*
}
