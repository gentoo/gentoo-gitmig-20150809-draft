# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/lsiutil/lsiutil-1.52.ebuild,v 1.1 2008/02/01 19:07:32 wschlich Exp $

inherit toolchain-funcs

DESCRIPTION="LSI Logic Fusion MPT Command Line Interface management tool"
HOMEPAGE="http://www.lsi.com/"
SRC_URI="http://www.lsi.com/support/downloads/hbas/fibre_channel/LsiUtil_10502.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="strip mirror test"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./Source/${PN}.tar.gz
}

src_compile() {
	cd "${S}"/${PN}
	$(tc-getCC) ${CFLAGS} -o ${PN} ${PN}.c
}

src_install() {
	dosbin ${PN}/${PN}
	dodoc "${S}"/LsiUtil_ReadMe.txt "${S}"/LSIUtil_UG.pdf "${S}"/*.TXT
}
