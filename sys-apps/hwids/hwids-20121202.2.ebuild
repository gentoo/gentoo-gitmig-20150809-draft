# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwids/hwids-20121202.2.ebuild,v 1.3 2012/12/02 07:21:00 ssuominen Exp $

EAPI=5
inherit udev

DESCRIPTION="Hardware (PCI, USB, OUI) IDs databases"
HOMEPAGE="https://github.com/gentoo/hwids"
SRC_URI="https://github.com/gentoo/hwids/archive/${P}.tar.gz
	http://cgit.freedesktop.org/systemd/systemd/plain/hwdb/ids-update.pl -> ids-update-${PV}.pl"

# freedist is for oui.txt, and it's mostly wishful thinking
LICENSE="|| ( GPL-2 BSD ) freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="+udev"

DEPEND="udev? ( dev-lang/perl !=sys-fs/udev-196 )"
RDEPEND="!<sys-apps/pciutils-3.1.9-r2
	!<sys-apps/usbutils-005-r1"

S=${WORKDIR}/hwids-${P}

src_unpack() { unpack ${P}.tar.gz; }

src_compile() {
	for file in {usb,pci}.ids; do
		gzip -c ${file} > ${file}.gz || die
	done

	if use udev; then
		perl "${DISTDIR}"/ids-update-${PV}.pl &>/dev/null || die
	fi
}

src_install() {
	insinto /usr/share/misc
	doins {usb,pci}.ids{,.gz} oui.txt

	dodoc README.md

	if use udev; then
		insinto "$(udev_get_udevdir)"/hwdb.d
		doins *.hwdb
	fi
}

pkg_postinst() {
	if use udev && has_version '>=virtual/udev-180'; then
		udevadm hwdb --update
	fi
}
