# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtinst/virtinst-0.300.1.ebuild,v 1.1 2007/10/15 11:16:31 dberkholz Exp $

inherit distutils rpm

DESCRIPTION="Python modules for starting virtualized guest installations"
HOMEPAGE="http://virt-manager.et.redhat.com/"
SRC_URI="http://virt-manager.et.redhat.com/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=app-emulation/libvirt-0.2.1
	dev-python/urlgrabber"
DEPEND="${RDEPEND}"

src_unpack() {
	rpm_src_unpack

	cd "${S}"
	epatch "${FILESDIR}"/${P}-nfs-check.patch
	epatch "${FILESDIR}"/${P}-remove-usb-tablet.patch

}
