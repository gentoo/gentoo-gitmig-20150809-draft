# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bo2k_console/bo2k_console-0.0.2_pre.ebuild,v 1.3 2004/10/14 20:11:51 dholm Exp $
MY_PV="0.0.2pre"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Command-line client based on LibBO2K."
HOMEPAGE="http://www.bo2k.com/"
SRC_URI="mirror://sourceforge/bo2k/${MY_P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=net-libs/libbo2k-0.1.5_pre"
#RDEPEND=""
S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README  COPYING INSTALL AUTHORS # NEWS ChangeLog <-- 0 Byte ??
}
