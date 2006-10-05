# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/tfm-fingerprint/tfm-fingerprint-1.0.ebuild,v 1.1 2006/10/05 13:45:13 wolf31o2 Exp $

DESCRIPTION="TouchChip TFM/ESS FingerPrint BSP"
HOMEPAGE="http://www.upek.com/support/dl_linux_bsp.asp"
SRC_URI="http://www.upek.com/support/download/TFMESS_BSP_LIN_${PV}.zip"

# This is the best license I could find.
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-auth/bioapi"

src_install() {
	insinto /usr/lib
	doins ${WORKDIR}/libtfmessbsp.so
	insinto /etc
	doins ${FILESDIR}/tfmessbsp.cfg
}

pkg_postinst() {
	einfo "Running Module Directory Services (MDS) ..."
	/opt/bioapi/bin/mod_install -fi /usr/lib/libtfmessbsp.so || die " mds libtfmessbsp failed"

	einfo "Note: You have to be in the group usb to access the fingerprint device."
}

pkg_prerm() {
	einfo "Running Module Directory Services (MDS) ..."
	/opt/bioapi/bin/mod_install -fu /usr/lib/libtfmessbsp.so
}
