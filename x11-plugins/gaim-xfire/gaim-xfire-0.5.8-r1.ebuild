# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-xfire/gaim-xfire-0.5.8-r1.ebuild,v 1.2 2006/01/24 00:24:04 metalgod Exp $


DESCRIPTION="Xfire plugin for gaim."
HOMEPAGE="http://www.fryx.ch/xfire/"
SRC_URI="mirror://sourceforge/gfire/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0"

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
}
