# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvacm4/dvacm4-0.3.1.ebuild,v 1.1 2003/03/06 18:54:06 pvdabeel Exp $

A=dvacm4-${PV}.tar.gz
S=${WORKDIR}/dvacm4-${PV}
DESCRIPTION="dvacm4 provides autoconf macros used by the dv* C++ utilities"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvacm/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvacm/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL2"
SLOT="0"

DEPEND="virtual/glibc"

src_install() {
	make prefix=${D}/usr install
}
