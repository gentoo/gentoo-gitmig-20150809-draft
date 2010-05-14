# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usb_modeswitch/usb_modeswitch-1.1.2.ebuild,v 1.1 2010/05/14 21:20:24 hanno Exp $

EAPI="2"
inherit multilib toolchain-funcs eutils

MY_PN="${PN/_/-}"
MY_P="${MY_PN}-${PV}"
DATA_VER="20100418"
DESCRIPTION="USB_ModeSwitch is a tool for controlling 'flip flop' (multiple devices) USB gear like UMTS sticks"
HOMEPAGE="http://www.draisberghof.de/usb_modeswitch/"
SRC_URI="http://www.draisberghof.de/usb_modeswitch/${MY_P}.tar.bz2
	http://www.draisberghof.de/usb_modeswitch/usb-modeswitch-data-${DATA_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=virtual/libusb-0*"
RDEPEND="${DEPEND}
		 dev-lang/tcl"
# TCL rdep is not an error. The runner script is written in it.

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.diff"
}

src_install() {
	UDEVDIR="/$(get_libdir)/udev/"
	emake install DESTDIR="${D}" UDEVDIR="${D}/${UDEVDIR}" || die
	cd "${WORKDIR}/usb-modeswitch-data-${DATA_VER}"
	emake files-install DESTDIR="${D}" UDEVDIR="${D}/${UDEVDIR}" || die
}
