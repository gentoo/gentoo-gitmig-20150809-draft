# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xineliboutput/vdr-xineliboutput-0.99.ebuild,v 1.1 2006/04/27 12:56:09 hd_brummy Exp $

inherit vdr-plugin eutils

MY_PV=${PV}rc
MY_P=${PN}-${MY_PV}

DESCRIPTION="Video Disk Recorder Xinelib PlugIn"
HOMEPAGE="http://users.tkk.fi/~phintuka/vdr/${PN}/"
SRC_URI="http://users.tkk.fi/~phintuka/vdr/${PN}/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.42
		>=media-libs/xine-lib-1.1.1"

S=${WORKDIR}/xineliboutput-${MY_PV}

PATCHES="${FILESDIR}/xineliboutput-0.99-makefile-gentoo.diff \
		${FILESDIR}/xineliboutput-0.99rc-amd64.patch"

pkg_setup() {
	vdr-plugin_pkg_setup

	XINE_LIB_VERSION=$(awk -F'"' '/XINE_VERSION/ {print $2}' /usr/include/xine.h)
}

src_install() {
	vdr-plugin_src_install

	dobin vdr-fbfe vdr-sxfe

	insinto ${VDR_PLUGIN_DIR}
	doins xineliboutput-fbfe.so.${MY_PV} xineliboutput-sxfe.so.${MY_PV}

	insinto /usr/lib/xine/plugins/${XINE_LIB_VERSION}
	doins xineplug_inp_xvdr.so
}
