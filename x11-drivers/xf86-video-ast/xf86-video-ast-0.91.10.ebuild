# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ast/xf86-video-ast-0.91.10.ebuild,v 1.3 2010/12/25 20:19:05 fauli Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X.Org driver for ASpeedTech cards"
KEYWORDS="amd64 x86 ~x86-fbsd"
LICENSE="MIT"

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xproto"
