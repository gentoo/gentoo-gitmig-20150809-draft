# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbo2k/libbo2k-0.1.5_pre.ebuild,v 1.1 2003/09/11 12:27:15 lordvan Exp $
MY_PV="0.1.5pre"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Linux BO2K communication library."
HOMEPAGE="http://www.bo2k.com/"
SRC_URI="mirror://sourceforge/bo2k/${MY_P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
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
