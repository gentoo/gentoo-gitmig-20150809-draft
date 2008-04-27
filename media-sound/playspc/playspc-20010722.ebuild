# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/playspc/playspc-20010722.ebuild,v 1.1 2008/04/27 04:49:09 drac Exp $

DESCRIPTION="a console program utilizing the SNeSe SPC core to play SPC files"
HOMEPAGE="http://playspc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

src_install() {
	dobin ${PN}
	dodoc README
}
