# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/lsiutil/lsiutil-1.60.ebuild,v 1.2 2009/01/13 12:02:27 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="LSI Logic Fusion MPT Command Line Interface management tool"
HOMEPAGE="http://www.lsi.com/"
SRC_URI="http://www.lsi.com/DistributionSystem/AssetDocument/support/downloads/hbas/fibre_channel/hardware_drivers/LSIUtil%20Kit_1.60.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="strip mirror test"

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./Source/${PN}.tar.gz
}

src_compile() {
	cd "${S}"/${PN}
	$(tc-getCC) ${CFLAGS} -o ${PN} ${PN}.c || die "emake failed."
}

src_install() {
	dosbin ${PN}/${PN} || die "dosbin failed."
	dodoc "${S}"/*.txt
}
