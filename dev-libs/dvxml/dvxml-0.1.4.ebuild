# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvxml/dvxml-0.1.4.ebuild,v 1.6 2008/02/01 04:49:00 halcy0n Exp $

S=${WORKDIR}/dvxml-${PV}
DESCRIPTION="dvxml provides some convenient stuff on top of the xmlwrapp package"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvxml/download/dvxml-${PV}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvxml/html/"
KEYWORDS="~x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/libc
	dev-libs/dvutil
	dev-libs/xmlwrapp"

src_install() {
	make prefix="${D}"/usr install
}
