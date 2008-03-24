# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-rotor/vdr-rotor-0.1.4-r1.ebuild,v 1.1 2008/03/24 10:03:51 hd_brummy Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="VDR Plugin: Add support for dishes with rotation control engine"
HOMEPAGE="http://home.vrweb.de/~bergwinkl.thomas/"
SRC_URI="http://home.vrweb.de/~bergwinkl.thomas/downro/${P}-vdr1.5.7.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"

DEPEND=">=media-video/vdr-1.3.44"

pkg_setup() {
	vdr-plugin_pkg_setup

	elog "Checking for patched vdr"
	if ! grep -q SendDiseqcCmd /usr/include/vdr/device.h; then
		ewarn "You need to emerge vdr with use-flag rotor set!"
		die "Unpatched vdr detected!"
	fi
}

src_unpack() {
	vdr-plugin_src_unpack

	if has_version ">=media-video/vdr-1.5.10" ; then
		epatch "${FILESDIR}/${P}_vdr-1.5.10.diff"
	fi

	sed -i "${S}"/filter.c \
		-e "s:libsi/:vdr/libsi/:"
}
