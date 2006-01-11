# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gartoon/gartoon-0.5.ebuild,v 1.3 2006/01/11 20:14:48 gustavoz Exp $

DESCRIPTION="Gartoon SVG icon theme."
SRC_URI="http://zeus.qballcow.nl/icon/paket/${P}.tar.gz"
HOMEPAGE="http://zeus.qballcow.nl/?page_id=15"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"

RESTRICT="nostrip"

S="${WORKDIR}/gartoon"

src_install(){
	cd ${S}

	insinto /usr/share/icons/
	doins -r ${S}
}
