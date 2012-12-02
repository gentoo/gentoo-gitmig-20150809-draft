# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwids/hwids-99999999.ebuild,v 1.3 2012/12/02 06:42:35 flameeyes Exp $

EAPI="4"

DESCRIPTION="Hardware (PCI, USB) IDs databases"
HOMEPAGE="https://github.com/gentoo/hwids"

# freedist is for oui.txt, and it's mostly wishful thinking
LICENSE="|| ( GPL-2 BSD ) freedist"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}"

DEPEND="net-misc/wget"
RDEPEND="!<sys-apps/pciutils-3.1.9-r2
	!<sys-apps/usbutils-005-r1"

src_compile() {
	wget http://pci-ids.ucw.cz/v2.2/pci.ids.gz http://www.linux-usb.org/usb.ids.gz http://standards.ieee.org/develop/regauth/oui/oui.txt || die

	for file in {usb,pci}.ids; do
		zcat ${file}.gz > ${file} || die
	done
}

src_install() {
	insinto /usr/share/misc
	doins {usb,pci}.ids{,.gz} oid.txt
}
