# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbo2k/libbo2k-0.1.5_pre.ebuild,v 1.3 2004/10/14 20:11:08 dholm Exp $
MY_PV="0.1.5pre"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Linux BO2K communication library."
HOMEPAGE="http://www.bo2k.com/"
SRC_URI="mirror://sourceforge/bo2k/${MY_P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=""
#RDEPEND=""
S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README  COPYING INSTALL # NEWS AUTHORS ChangeLog <-- 0 Byte ??
}
