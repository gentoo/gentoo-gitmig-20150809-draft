# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-qxl/xf86-video-qxl-0.0.13.ebuild,v 1.2 2011/03/21 13:40:48 hwoarang Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="QEMU QXL paravirt video driver"

KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="x11-base/xorg-server[-minimal]"
DEPEND="${RDEPEND}
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xf86dgaproto"
