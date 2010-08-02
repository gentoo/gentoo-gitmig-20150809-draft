# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.12.6.ebuild,v 1.6 2010/08/02 17:55:20 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

EAPI=2

inherit x-modular eutils

DESCRIPTION="ATI video driver"

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

#SRC_PATCHES="http://dev.gentooexperimental.org/~scarabeus/${PV}-patches-01.tar.bz2"
SRC_URI="${SRC_URI}
	${SRC_PATCHES}"

RDEPEND=">=x11-base/xorg-server-1.2[-minimal]"
DEPEND="${RDEPEND}
	>=x11-libs/libdrm-2
	x11-proto/fontsproto
	x11-proto/glproto
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xf86driproto
	x11-proto/xf86miscproto
	x11-proto/xproto
"
CONFIGURE_OPTIONS="--enable-dri"

src_prepare() {
	x-modular_src_prepare
	if [[ -n "${SRC_PATCHES}" ]]; then
		EPATCH_FORCE="yes" \
		EPATCH_SOURCE="${WORKDIR}/patches" \
		EPATCH_SUFFIX="patch" \
		epatch
	fi
}

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "If you have a mach64 or r128 video card, read this"
	ewarn "The mach64 and r128 drivers moved to their own packages,"
	ewarn "xf86-video-mach64 and xf86-video-r128. If these weren't installed"
	ewarn "automatically by xorg-server and you have one of these cards,"
	ewarn "check your VIDEO_CARDS settings."
}
