# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvcgi/dvcgi-0.5.10.ebuild,v 1.4 2004/06/24 23:06:24 agriffis Exp $

DESCRIPTION="dvcgi provides a C++ interface for C++ cgi programs"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvcgi/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvcgi/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc"

IUSE=""

DEPEND="virtual/glibc
	dev-libs/dvutil
	dev-libs/dvnet"

src_install() {
	make prefix=${D}/usr install
}
