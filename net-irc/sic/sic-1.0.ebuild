# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/sic/sic-1.0.ebuild,v 1.2 2009/10/03 09:57:09 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="An extremly simple IRC client"
HOMEPAGE="http://www.suckless.org/programs/sic.html"
SRC_URI="http://code.suckless.org/dl/tools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/CFLAGS =/CFLAGS +=/g" \
		-e "s/-Os//" \
		-e "s/LDFLAGS =/LDFLAGS +=/" \
		-e "s/-s //g" \
		-e "s/= cc/= $(tc-getCC)/g" \
		config.mk || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	dodoc README
}
