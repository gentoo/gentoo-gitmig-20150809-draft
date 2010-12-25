# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-geode/xf86-video-geode-2.11.10.ebuild,v 1.2 2010/12/25 20:20:36 fauli Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="AMD Geode GX and LX video driver"

KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.5"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	>=x11-proto/randrproto-1.2
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xproto"
