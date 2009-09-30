# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-vga/xf86-video-vga-4.1.0.ebuild,v 1.8 2009/09/30 21:21:31 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Generic VGA video driver"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xproto"
