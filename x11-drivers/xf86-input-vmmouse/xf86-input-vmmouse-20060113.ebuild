# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-vmmouse/xf86-input-vmmouse-20060113.ebuild,v 1.1 2006/01/16 21:56:40 battousai Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for the VMWare virtual mouse"
KEYWORDS="~x86"
RDEPEND=">=x11-base/xorg-server-0.99.3"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"

PATCHES="${FILESDIR}/${P}-PIC-fix.patch"
