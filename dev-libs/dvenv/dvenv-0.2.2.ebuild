# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvenv/dvenv-0.2.2.ebuild,v 1.4 2004/03/17 09:03:15 seemant Exp $

DESCRIPTION="dvenv provides polymorphic tree-structured environments, generalizing the Dv::Util::Props class"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvenv/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvenv/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

IUSE=""

DEPEND="virtual/glibc
	dev-libs/dvutil"

src_install() {
	make prefix=${D}/usr install
}
