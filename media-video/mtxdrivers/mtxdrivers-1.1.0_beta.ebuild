# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mtxdrivers/mtxdrivers-1.1.0_beta.ebuild,v 1.2 2003/12/29 17:21:38 spyderous Exp $

inherit matrox

MY_PV="${PV/_/-}"
MY_P="${PN}-rh9.0-v${MY_PV}"
DESCRIPTION="Drivers for the Matrox Parhelia and Millenium P650/P750 cards."
SRC_URI="${MY_P}.run"

KEYWORDS="~x86"

RDEPEND="!media-video/mtxdrivers-pro"
S="${WORKDIR}"

pkg_nofetch() {
	einfo "You must go to: http://www.matrox.com/mga/registration/home.cfm?refid=7667"
	einfo "(for the RH9.0 drivers) and log in (or create an account) to download the"
	einfo "Matrox Parhelia drivers. Remember to right-click and use Save Link As when"
	einfo "downloading the driver."
}

src_unpack() {
	tail -n 4907 ${DISTDIR}/${A} | tar xvzf -
}

src_install() {
	# Install 2D driver and DRM kernel module
	matrox_base_src_install

	dodoc README* samples/*
}
