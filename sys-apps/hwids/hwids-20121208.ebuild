# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwids/hwids-20121208.ebuild,v 1.1 2012/12/08 11:30:12 flameeyes Exp $

EAPI=5
inherit udev

DESCRIPTION="Hardware (PCI, USB, OUI, IAB) IDs databases"
HOMEPAGE="https://github.com/gentoo/hwids"
SRC_URI="https://github.com/gentoo/hwids/archive/${P}.tar.gz"

LICENSE="|| ( GPL-2 BSD ) public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="+udev"

DEPEND="udev? ( dev-lang/perl !=sys-fs/udev-196 )"
RDEPEND="!<sys-apps/pciutils-3.1.9-r2
	!<sys-apps/usbutils-005-r1"

src_compile() {
	for file in {usb,pci}.ids; do
		gzip -c ${file} > ${file}.gz || die
	done

	if use udev; then
		emake udev-hwdb
	fi
}

src_install() {
	insinto /usr/share/misc
	doins {usb,pci}.ids{,.gz} oui.txt iab.txt

	dodoc README.md

	if use udev; then
		insinto "$(udev_get_udevdir)"/hwdb.d
		doins udev/*.hwdb
	fi
}

pkg_postinst() {
	if use udev && [[ $(udevadm --help 2>&1) == *hwdb* ]]; then
		udevadm hwdb --update
	fi
}
