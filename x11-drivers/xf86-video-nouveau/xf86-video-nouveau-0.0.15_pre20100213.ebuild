# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-nouveau/xf86-video-nouveau-0.0.15_pre20100213.ebuild,v 1.1 2010/02/15 21:38:01 chithanh Exp $

EAPI=2
SNAPSHOT="yes"
inherit linux-info x-modular

DESCRIPTION="Nouveau video driver"
HOMEPAGE="http://nouveau.freedesktop.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.7[-minimal]
	>=x11-libs/libdrm-2.4.18_pre"

DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86driproto
	x11-proto/xproto"

pkg_postinst() {
	x-modular_pkg_postinst
	if ! has_version x11-base/nouveau-drm; then
		if ! linux_config_exists || ! linux_chkconfig_present DRM_NOUVEAU; then
			ewarn "Nouveau DRM not detected. If you want any kind of"
			ewarn "acceleration with nouveau, emerge x11-base/nouveau-drm or"
			ewarn "enable CONFIG_DRM_NOUVEAU in the kernel."
		fi
	fi
	if ! has_version x11-drivers/nouveau-firmware; then
		ewarn "Nouveau firmware not detected, for acceleration on NV50 (G80)"
		ewarn "and newer chipsets, emerge x11-drivers/nouveau-firmware."
	fi
}
