# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvacm4/dvacm4-0.3.3.ebuild,v 1.2 2004/03/14 12:28:57 mr_bones_ Exp $

A=dvacm4-${PV}.tar.gz
S=${WORKDIR}/dvacm4-${PV}
DESCRIPTION="dvacm4 provides autoconf macros used by the dv* C++ utilities"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvacm4/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvacm4/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc"
RDEPEND=${DEPEND}

src_install() {
	make prefix=${D}/usr install
}
