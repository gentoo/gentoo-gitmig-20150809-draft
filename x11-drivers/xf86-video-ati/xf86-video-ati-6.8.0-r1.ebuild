# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.8.0-r1.ebuild,v 1.12 2009/05/04 15:54:20 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="ATI video driver"

KEYWORDS="alpha amd64 ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.2"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xf86miscproto
	x11-proto/xproto
	dri? ( x11-proto/glproto
			x11-proto/xf86driproto
			>=x11-libs/libdrm-2 )"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}

PATCHES=(
	"${FILESDIR}/${PV}/0001-Bump-CRTC-size-limits-on-AVIVO-chips-so-30-displays.patch"
	"${FILESDIR}/${PV}/0002-RADEON-update-man-page-with-supported-chips.patch"
	"${FILESDIR}/${PV}/0003-RADEON-fix-DDC-types-5-and-6.patch"
	"${FILESDIR}/${PV}/0004-RADEON-restore-clock-gating-and-CP-clock-errata-on.patch"
	"${FILESDIR}/${PV}/0005-R100-fix-render-accel-for-transforms.patch"
	"${FILESDIR}/${PV}/0006-radeon-Fix-typo-flagged-by-gcc-Wall.patch"
	"${FILESDIR}/${PV}/0007-ATOM-properly-set-up-DDIA-output-on-RS6xx-boards.patch"
	"${FILESDIR}/${PV}/0008-RS6xx-fix-DDC-on-DDIA-output-usually-HDMI-port.patch"
	"${FILESDIR}/${PV}/0134-Disable-the-setting-of-HARDWARE_CURSOR_BIT_ORDER_MSB.patch"
)

src_install() {
	x-modular_src_install
	insinto /usr/share/hwdata/videoaliases
	doins "${FILESDIR}/old_hw_data/ati.xinf"
	doins "${FILESDIR}/old_hw_data/r128.xinf"
}
