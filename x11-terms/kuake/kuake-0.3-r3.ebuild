# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/kuake/kuake-0.3-r3.ebuild,v 1.5 2005/08/24 08:26:55 greg_g Exp $

inherit kde eutils

DESCRIPTION="A Quake-style terminal emulator."
HOMEPAGE="http://www.nemohackers.org/kuake.php"
SRC_URI="http://199.231.140.154/software/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="arts"

DEPEND="|| ( kde-base/konsole kde-base/kdebase )"

need-kde 3.3

src_unpack() {
	kde_src_unpack

	epatch "${FILESDIR}/${P}-dropdown-fix.patch"
	epatch "${FILESDIR}/${P}-alignment-fix.patch"

	use arts || {
		epatch "${FILESDIR}/${P}-noarts-fix.patch"
		rm -f ${S}/configure
	}
}
