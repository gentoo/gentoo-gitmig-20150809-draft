# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/fwdl/fwdl-1.2.3.ebuild,v 1.1 2007/02/06 07:28:39 robbat2 Exp $

DESCRIPTION="Seagate Fibre-Channel disk firmware upgrade tool"
HOMEPAGE="http://www.tc.umn.edu/~erick205/Projects/"
SRC_URI="http://www.tc.umn.edu/~erick205/Projects/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND=""

src_compile() {
	emake OPTIMIZER="${CXXFLAGS}"
}

src_install() {
	dosbin fwdl
	dodoc CHANGES INSTALL README
}
