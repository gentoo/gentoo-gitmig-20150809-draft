# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-xgi/xf86-video-xgi-1.6.0.ebuild,v 1.2 2010/12/25 20:23:58 fauli Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="XGI video driver"

KEYWORDS="~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xproto"
