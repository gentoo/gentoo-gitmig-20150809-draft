# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-vmware/xf86-video-vmware-11.0.2.ebuild,v 1.2 2010/09/30 03:48:22 chithanh Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="VMware SVGA video driver"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99.901
	|| ( <x11-libs/libdrm-2.4.22 x11-libs/libdrm[libkms,video_cards_vmware] )"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto"
