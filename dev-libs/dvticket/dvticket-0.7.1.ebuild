# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvticket/dvticket-0.7.1.ebuild,v 1.1 2003/10/28 22:25:46 pvdabeel Exp $

A=dvticket-${PV}.tar.gz
S=${WORKDIR}/dvticket-${PV}
DESCRIPTION="dvticket provides a framework for a ticket server"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvticket/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvticket/html/"
KEYWORDS="~x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-libs/dvutil
	dev-libs/dvnet
	dev-libs/dvcgi"
RDEPEND=${DEPEND}

src_install() {
	make prefix=${D}/usr install
}
