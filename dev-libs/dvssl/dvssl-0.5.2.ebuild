# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvssl/dvssl-0.5.2.ebuild,v 1.4 2004/03/14 12:08:15 mr_bones_ Exp $

S=${WORKDIR}/dvssl-${PV}
DESCRIPTION="dvssl provides a simple interface to openssl"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvssl/download/dvssl-${PV}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvssl/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-libs/openssl
	dev-libs/dvutil
	dev-libs/dvnet"
RDEPEND=${DEPEND}

src_install() {
	make prefix=${D}/usr install || die
}
