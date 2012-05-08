# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Fast SSL port scanner"
HOMEPAGE="http://www.titania.co.uk/sslscan.php"
SRC_URI="mirror://sourceforge/sslscan/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/gcc -g/$(CC)/' Makefile || die
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	dobin sslscan
	doman sslscan.1
	dodoc Changelog
}
