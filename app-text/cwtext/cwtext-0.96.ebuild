# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cwtext/cwtext-0.96.ebuild,v 1.3 2011/12/14 09:18:08 phajdan.jr Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Text to Morse Code converter"
HOMEPAGE="http://cwtext.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# change install directory to ${S}
	sed -i -e "/^PREFIX/ s:=.*:=\"${S}\":" makefile || \
		die "sed makefile failed"

	epatch "${FILESDIR}"/${PN}-0.94-asneeded.patch
	tc-export CC
}

src_install() {
	dobin cwtext cwpcm cwmm || die "dobin failed"

	dodoc Changes README TODO
}
