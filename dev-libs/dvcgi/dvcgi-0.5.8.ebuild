# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvcgi/dvcgi-0.5.8.ebuild,v 1.1 2003/07/14 18:55:12 pvdabeel Exp $

A=dvcgi-${PV}.tar.gz
S=${WORKDIR}/dvcgi-${PV}
DESCRIPTION="dvcgi provides a C++ interface for C++ cgi programs"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvcgi/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvcgi/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-libs/dvutil
	dev-libs/dvnet"
RDEPEND=${DEPEND}

src_install() {
	make prefix=${D}/usr install
}
