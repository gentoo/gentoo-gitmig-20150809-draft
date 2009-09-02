# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/lsiutil/lsiutil-1.60-r1.ebuild,v 1.2 2009/09/02 02:09:22 robbat2 Exp $

inherit toolchain-funcs

DESCRIPTION="LSI Logic Fusion MPT Command Line Interface management tool"
HOMEPAGE="http://www.lsi.com/"
SRC_URI="http://www.lsi.com/DistributionSystem/AssetDocument/support/downloads/hbas/fibre_channel/hardware_drivers/LSIUtil%20Kit_${PV}.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="strip mirror test bindist"

RDEPEND=""
DEPEND="app-arch/unzip
		>=sys-kernel/linux-headers-2.6.27-r2"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	# nested files
	unpack ./Source/${PN}.tar.gz
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN} ${PN}.c || die "emake failed."
}

src_install() {
	dosbin ${PN} || die "dosbin failed."
	dodoc "${WORKDIR}"/*.txt
}

pkg_postinst() {
	einfo "See LsiUtil_ReadMe.txt for a list of supported controllers"
	einfo "and general usage information."
}
