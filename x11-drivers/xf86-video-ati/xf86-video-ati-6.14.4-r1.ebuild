# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.14.4-r1.ebuild,v 1.1 2012/04/24 13:13:19 chithanh Exp $

EAPI=4

XORG_DRI=always
inherit xorg-2

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libdrm-2.4.31[video_cards_radeon]"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PV}-6.14.3-exa-solid-accel-r300.patch
	"${FILESDIR}"/${PV}-6.14.3-exa-solid-accel-evergreen.patch
	"${FILESDIR}"/${PV}-6.14.3-exa-solid-accel-r100.patch
	"${FILESDIR}"/${PV}-6.14.3-exa-solid-accel-r200.patch
)

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		--enable-dri
		--enable-kms
		--enable-exa
	)
}
