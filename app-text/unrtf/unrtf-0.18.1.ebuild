# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.18.1.ebuild,v 1.2 2003/10/20 08:51:37 hanno Exp $

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/${PN}/${PN}.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
		 mirror://gentoo/${P}-gcc33.patch.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${DISTDIR}/unrtf-0.18.1-gcc33.patch.gz
}

src_compile() {
	emake || die
}

src_install() {
	dobin unrtf
	doman unrtf.1
	dohtml doc/unrtf.html
	dodoc CHANGES COPYING README TODO
}
