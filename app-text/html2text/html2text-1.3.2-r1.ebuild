# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html2text/html2text-1.3.2-r1.ebuild,v 1.2 2010/01/02 11:22:49 fauli Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A HTML to text converter"
HOMEPAGE="http://www.mbayer.de/html2text/index.shtml"
SRC_URI="http://userpage.fu-berlin.de/~mbayer/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch 1.3.2_to_1.3.2a.diff
	epatch "${FILESDIR}"/${P}-compiler.patch
}

src_compile() {
	econf || die
	emake CXX="$(tc-getCXX)" LDFLAGS="${LDFLAGS}" DEBUG="${CXXFLAGS}" || die
}

src_install() {
	dobin html2text || die "dobin failed"
	doman html2text.1.gz html2textrc.5.gz || die "doman failed"
	dodoc CHANGES CREDITS KNOWN_BUGS README TODO
}
