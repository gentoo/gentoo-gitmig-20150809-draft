# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/kyro-drivers/kyro-drivers-2.01.21.7.ebuild,v 1.2 2006/01/18 23:57:15 spyderous Exp $

inherit eutils

MY_PV="${PV%.*}-${PV#*.*.*.}"
MY_P="powervr-${MY_PV}"
MY_PRE_PV="${MY_PV/7/0007}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="XFree86 DRI drivers for the KyroII card"
HOMEPAGE="http://www.powervr.com/"
SRC_URI="http://www.powervr.com/Downloads/Drivers/${MY_PRE_PV//./-}/${MY_P}.tgz"

LICENSE="ImaginationTechnologies"
SLOT="${KV}"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="nostrip"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/linux-sources
	>=sys-apps/portage-1.9.10"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/mtrr-include-fix.diff
}

src_compile() {
	check_KV
	make || die
}

src_install() {
	insinto /lib/modules/${KV}/drivers/char/drm/
	doins powervr.o

	dolib.so lib*.so
	dolib.a lib*.a

	insinto /usr/X11R6/lib/modules/dri
	doins powervr_dri.so

	insinto /usr/X11R6/lib/modules/drivers
	doins powervr_drv.o

	insinto /etc
	doins powervr_kyro.ini

	dosym /usr/lib/libPVR2D.so /usr/X11R6/lib/modules/drivers/libPVR2D.so

	dodoc XF86KyroSampleConfig LICENSE.TXT README
}
