# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aggregate-flim/aggregate-flim-1.0.2.ebuild,v 1.11 2007/06/10 19:41:45 robbat2 Exp $

MY_PN="${PN/-flim}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="aggregate is a tool for aggregating CIDR networks."
HOMEPAGE="http://www.vergenet.net/linux/aggregate-flim/"
SRC_URI="http://www.vergenet.net/linux/aggregate-flim/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 x86"
IUSE=""
DEPEND="dev-libs/vanessa-logger"
#RDEPEND=""
S=${WORKDIR}/${MY_P}

src_install() {
	newbin aggregate aggregate-flim
	newman aggregate.8 aggregate-flim.8
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
