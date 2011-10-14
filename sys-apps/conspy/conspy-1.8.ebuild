# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/conspy/conspy-1.8.ebuild,v 1.1 2011/10/14 23:26:09 radhermit Exp $

EAPI=4
inherit autotools

DESCRIPTION="Remote control for virtual consoles"
HOMEPAGE="http://ace-host.stuart.id.au/russell/files/conspy"
SRC_URI="http://ace-host.stuart.id.au/russell/files/${PN}/${P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	default
	dohtml ${PN}.html
}
