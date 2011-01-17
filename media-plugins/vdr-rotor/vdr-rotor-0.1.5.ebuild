# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-rotor/vdr-rotor-0.1.5.ebuild,v 1.3 2011/01/17 22:02:23 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Add support for dishes with rotation control engine"
HOMEPAGE="http://home.vrweb.de/~bergwinkl.thomas/"
SRC_URI="http://home.vrweb.de/~bergwinkl.thomas/downro/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86 amd64"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0[rotor]"
RDEPEND="${DEPEND}"

pkg_setup() {
	vdr-plugin_pkg_setup

	elog "Checking for patched vdr"
	if ! grep -q SendDiseqcCmd /usr/include/vdr/device.h; then
		ewarn "You need to emerge vdr with use-flag rotor set!"
		die "Unpatched vdr detected!"
	fi
}

src_prepare() {
	vdr-plugin_src_prepare

	if has_version ">=media-video/vdr-1.7.13"; then
		epatch "${FILESDIR}/${P}_vdr-1.7.13.diff"
	fi
}
