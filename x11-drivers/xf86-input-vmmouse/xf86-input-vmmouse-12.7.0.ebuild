# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-vmmouse/xf86-input-vmmouse-12.7.0.ebuild,v 1.2 2011/03/21 13:40:02 hwoarang Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="VMWare mouse input driver"
IUSE=""
KEYWORDS="amd64 ~x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-1.4.1
	x11-proto/randrproto
	x11-proto/xproto"
