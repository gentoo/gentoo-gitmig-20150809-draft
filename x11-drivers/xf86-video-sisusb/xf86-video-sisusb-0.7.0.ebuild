# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-sisusb/xf86-video-sisusb-0.7.0.ebuild,v 1.3 2005/09/04 08:39:01 matsuu Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for sisusb cards"
KEYWORDS="~sh ~sparc ~x86"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/xproto"
