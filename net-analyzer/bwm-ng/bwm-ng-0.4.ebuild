# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwm-ng/bwm-ng-0.4.ebuild,v 1.1 2005/01/22 20:14:00 hollow Exp $

DESCRIPTION="Bandwidth Monitor NG is a small and simple console-based bandwidth monitor for Linux, BSD, and Mac OS X"
SRC_URI="http://gropp.org/${PN}-${PV}.tar.gz"
HOMEPAGE="http://gropp.org/"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.4-r4
	>=sys-apps/net-tools-1.60-r1"

src_install() {
	dobin bwm-ng
	dodoc README
}
