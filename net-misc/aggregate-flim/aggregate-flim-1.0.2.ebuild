# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aggregate-flim/aggregate-flim-1.0.2.ebuild,v 1.1 2003/09/13 07:07:49 robbat2 Exp $

MY_PN="${PN/-flim}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="aggregate is a tool for aggregating CIDR networks."
HOMEPAGE="http://www.vergenet.net/linux/${MY_PN}/"
SRC_URI="${HOMEPAGE}/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-libs/vanessa-logger"
#RDEPEND=""
S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING COPYING ChangeLog INSTALL NEWS README
}
