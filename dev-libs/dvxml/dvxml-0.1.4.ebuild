# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvxml/dvxml-0.1.4.ebuild,v 1.2 2004/03/14 12:11:02 mr_bones_ Exp $

S=${WORKDIR}/dvxml-${PV}
DESCRIPTION="dvxml provides some convenient stuff on top of the xmlwrapp package"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvxml/download/dvxml-${PV}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvxml/html/"
KEYWORDS="~x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-libs/dvutil
	dev-libs/xmlwrapp"
RDEPEND=${DEPEND}

src_install() {
	make prefix=${D}/usr install
}
