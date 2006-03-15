# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwm-ng/bwm-ng-0.5.ebuild,v 1.3 2006/03/15 13:27:12 deltacow Exp $

DESCRIPTION="Bandwidth Monitor NG is a small and simple console-based bandwidth monitor for Linux, BSD, and Mac OS X"
SRC_URI="http://www.gropp.org/bwm-ng/${P}.tar.gz"
HOMEPAGE="http://www.gropp.org/"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="html csv ncurses"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.4-r4
	>=sys-apps/net-tools-1.60-r1"

src_compile() {
	econf `use_enable html` `use_enable csv` --with-ncurses || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/bwm-ng
	doman bwm-ng.1
	dodoc README AUTHORS changelog
}
