# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvutil/dvutil-0.13.3.ebuild,v 1.3 2003/03/27 05:28:19 vladimir Exp $

A=dvutil-${PV}.tar.gz
S=${WORKDIR}/dvutil-${PV}
DESCRIPTION="dvutil provides some general C++ utility classes for files, directories, dates, property lists, reference counted pointers, number conversion etc. "
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvutil/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvutil/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc"
RDEPEND=${DEPEND}

src_install() {
	make prefix=${D}/usr install
}
