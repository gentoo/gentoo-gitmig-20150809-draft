# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/openmoko-dfu-util/openmoko-dfu-util-9999.ebuild,v 1.1 2008/09/06 00:56:02 vapier Exp $

ESVN_REPO_URI="http://svn.openmoko.org/trunk/src/host/dfu-util/"
inherit subversion autotools

DESCRIPTION="implements the Host (PC) side of the USB DFU (Device Firmware Upgrade) protocol"
HOMEPAGE="http://wiki.openmoko.org/wiki/Dfu-util"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libusb"

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	sed -i '/^bin_PROGRAMS/s:dfu-util_static::' src/Makefile.am
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "Make install failed"
}
