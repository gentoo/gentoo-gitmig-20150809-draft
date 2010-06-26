# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usb_modeswitch/usb_modeswitch-1.1.3.ebuild,v 1.1 2010/06/26 10:52:51 ssuominen Exp $

EAPI=2
inherit multilib toolchain-funcs

MY_P=${PN/_/-}-${PV}
DATA_VER=20100623

DESCRIPTION="USB_ModeSwitch is a tool for controlling 'flip flop' (multiple devices) USB gear like UMTS sticks"
HOMEPAGE="http://www.draisberghof.de/usb_modeswitch/"
SRC_URI="http://www.draisberghof.de/${PN}/${MY_P}.tar.bz2
	http://www.draisberghof.de/${PN}/${PN/_/-}-data-${DATA_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}
	dev-lang/tcl" # usb_modeswitch script is tcl

S=${WORKDIR}/${MY_P}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	local udevdir="/$(get_libdir)/udev/"
	emake install DESTDIR="${D}" UDEVDIR="${D}/${udevdir}" || die
	cd ../${PN/_/-}-data-${DATA_VER}
	emake files-install DESTDIR="${D}" UDEVDIR="${D}/${udevdir}" || die
}
