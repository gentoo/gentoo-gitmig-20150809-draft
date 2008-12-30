# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdircmp/cdircmp-0.3.ebuild,v 1.10 2008/12/30 19:35:53 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="Compare directories and select files to copy"
HOMEPAGE="http://home.hccnet.nl/paul.schuurmans/"
SRC_URI="http://home.hccnet.nl/paul.schuurmans/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README

	dobin ${PN} || die "dobin failed"
}
