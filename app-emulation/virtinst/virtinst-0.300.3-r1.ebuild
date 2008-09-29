# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtinst/virtinst-0.300.3-r1.ebuild,v 1.2 2008/09/29 12:36:32 dev-zero Exp $

inherit distutils eutils rpm

DESCRIPTION="Python modules for starting virtualized guest installations"
HOMEPAGE="http://virt-manager.et.redhat.com/"
SRC_URI="http://virt-manager.et.redhat.com/download/sources/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-patches-${PV}-1.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=app-emulation/libvirt-0.2.1
	dev-python/urlgrabber"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SOURCE="${WORKDIR}/patches"
	EPATCH_SUFFIX="patch"
	epatch
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "Please select the following os-type/-variant if you want virtio_net and/or virtio_blk support:"
	elog "|  os   |     variant    |  virtio_net | virtio_blk |"
	elog "| linux |  gentoostable  |     yes     |     no     |"
	elog "| linux | gentoounstable |     yes     |     yes    |"
	elog "| linux |   ubuntuHardy  |     yes     |     no     |"
}
