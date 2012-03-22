# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html2text/html2text-1.3.2a.ebuild,v 1.1 2012/03/22 16:41:43 floppym Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="A HTML to text converter"
HOMEPAGE="http://www.mbayer.de/html2text/"
SRC_URI="http://www.mbayer.de/html2text/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-compiler.patch
	epatch "${FILESDIR}"/${P}-urlistream-get.patch
}

src_configure() {
	tc-export CXX
	default
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}" DEBUG="${CXXFLAGS}"
}

src_install() {
	dobin html2text
	doman html2text.1.gz html2textrc.5.gz
	dodoc CHANGES CREDITS KNOWN_BUGS README TODO
}
