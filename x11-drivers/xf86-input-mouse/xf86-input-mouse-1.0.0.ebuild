# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-mouse/xf86-input-mouse-1.0.0.ebuild,v 1.5 2005/09/04 08:36:27 matsuu Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for mouse input devices"
KEYWORDS="~amd64 ~ppc ~sh ~sparc ~x86"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/xproto"
