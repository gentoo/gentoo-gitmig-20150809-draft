# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvssl/dvssl-0.5.2.ebuild,v 1.5 2004/06/14 17:27:39 kloeri Exp $

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

src_install() {
	make prefix=${D}/usr install || die
}
