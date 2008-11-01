# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkfep/skkfep-0.87-r1.ebuild,v 1.1 2008/11/01 02:46:54 matsuu Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A SKK-like Japanese input method for console"
HOMEPAGE="http://homepage2.nifty.com/aito/soft.html"
SRC_URI="http://homepage2.nifty.com/aito/skkfep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-apps/gawk"
RDEPEND="${RDEPEND}
	app-i18n/skk-jisyo"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" OPTIMIZE="${CFLAGS}" || die
}

src_install() {
	dobin skkfep escmode || die
	doman skkfep.1

	dodoc README HISTORY TODO
}
