# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdircmp/cdircmp-0.3.ebuild,v 1.7 2005/03/22 16:05:36 kloeri Exp $

DESCRIPTION="Compare directories and select files to copy"
HOMEPAGE="http://home.hccnet.nl/paul.schuurmans/"
SRC_URI="http://home.hccnet.nl/paul.schuurmans/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_install() {
	dodoc AUTHORS ChangeLog README

	dobin ${PN}
}
