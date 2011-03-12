# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gromit/gromit-20041213-r1.ebuild,v 1.2 2011/03/12 21:41:24 radhermit Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="GRaphics Over MIscellaneous Things, a presentation helper"
HOMEPAGE="http://www.home.unix-ag.org/simon/gromit"
SRC_URI="http://www.home.unix-ag.org/simon/gromit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i Makefile \
		-e 's:-Wall:-Wall $(CFLAGS) $(LDFLAGS):' \
		-e 's:gcc:$(CC):g' \
		|| die "sed Makefile failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	dobin ${PN}
	newdoc ${PN}rc ${PN}rc.example
	dodoc AUTHORS ChangeLog README
}
