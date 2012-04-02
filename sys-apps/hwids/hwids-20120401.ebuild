# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwids/hwids-20120401.ebuild,v 1.3 2012/04/02 03:59:20 jer Exp $

EAPI="4"

DESCRIPTION="Hardware (PCI, USB) IDs databases"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/hwids.git;a=summary"
SRC_URI="http://dev.gentoo.org/~flameeyes/hwids/${P}.tar.xz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86-fbsd"
IUSE=""

S="${WORKDIR}"

DEPEND=""
RDEPEND="!<sys-apps/pciutils-3.1.9-r2
	!<sys-apps/usbutils-005-r1"

src_compile() {
	for file in {usb,pci}.ids; do
		gzip -c ${file} > ${file}.gz || die
	done
}

src_install() {
	insinto /usr/share/misc
	doins {usb,pci}.ids{,.gz}
}
