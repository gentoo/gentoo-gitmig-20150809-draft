# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aggregate-flim/aggregate-flim-1.0.2.ebuild,v 1.4 2004/02/22 23:27:48 agriffis Exp $

MY_PN="${PN/-flim}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="aggregate is a tool for aggregating CIDR networks."
HOMEPAGE="http://www.vergenet.net/linux/${MY_PN}/"
SRC_URI="${HOMEPAGE}/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~hppa ia64 amd64 ~sparc ~mips"
IUSE=""
DEPEND="dev-libs/vanessa-logger"
#RDEPEND=""
S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	into /usr
	newbin aggregate aggregate-flim
	newman aggregate.8 aggregate-flim.8
	dodoc AUTHORS COPYING COPYING ChangeLog INSTALL NEWS README
}
