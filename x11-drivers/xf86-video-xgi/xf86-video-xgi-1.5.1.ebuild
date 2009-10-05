# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-xgi/xf86-video-xgi-1.5.1.ebuild,v 1.2 2009/10/05 14:39:29 fauli Exp $

inherit x-modular

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
