# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xineliboutput/vdr-xineliboutput-1.0.0_pre3.ebuild,v 1.1 2006/08/28 14:14:15 zzam Exp $

inherit vdr-plugin eutils multilib

MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Video Disk Recorder Xinelib PlugIn"
HOMEPAGE="http://users.tkk.fi/~phintuka/vdr/vdr-xineliboutput/"
SRC_URI="http://users.tkk.fi/~phintuka/vdr/${PN}/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=media-video/vdr-1.3.42
		>=media-libs/xine-lib-1.1.1
		media-libs/jpeg
		|| ( (
				x11-proto/xextproto
				x11-proto/xf86vidmodeproto
				x11-proto/xproto
			)
			virtual/x11
		)"

DEPEND="${RDEPEND}
		sys-kernel/linux-headers
		|| ( (
				x11-libs/libX11
				x11-libs/libXv
				x11-libs/libXext
			)
			virtual/x11
		)"

S=${WORKDIR}/xineliboutput-${MY_PV}

pkg_setup() {
	vdr-plugin_pkg_setup

	XINE_LIB_VERSION=$(awk -F'"' '/XINE_VERSION/ {print $2}' /usr/include/xine.h)
}

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	einfo "Enabling all configuration options"
	sed -i.orig Makefile \
		-e 's:^#XINELIBOUTPUT:XINELIBOUTPUT:'

	# patching makefile to work with this
	# $ rm ${outdir}/file; cp file ${outdir}/file
	# work in the sandbox
	sed -i.orig Makefile \
		-e 's:XINEPLUGINDIR.*=.*:XINEPLUGINDIR = '"${WORKDIR}/lib:"
	mkdir -p ${WORKDIR}/lib
}

src_install() {
	vdr-plugin_src_install

	dobin vdr-fbfe vdr-sxfe

	insinto ${VDR_PLUGIN_DIR}
	doins *.so.${MY_PV}

	insinto /usr/$(get_libdir)/xine/plugins/${XINE_LIB_VERSION}
	doins xineplug_inp_xvdr.so
}
