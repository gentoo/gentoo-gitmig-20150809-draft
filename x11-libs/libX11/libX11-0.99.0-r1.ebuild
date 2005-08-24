# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libX11/libX11-0.99.0-r1.ebuild,v 1.2 2005/08/24 01:06:54 vapier Exp $

# FIXME: Add USE flags

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

PATCHES="${FILESDIR}/fix-xkeysymdb-location.patch"

DESCRIPTION="X.Org X11 library"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sparc ~x86"
IUSE="ipv6"
RDEPEND="x11-libs/xtrans
	x11-libs/libXau
	x11-libs/libXdmcp"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/bigreqsproto
	x11-proto/xextproto
	x11-proto/xcmiscproto
	x11-proto/kbproto
	x11-proto/inputproto"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
# xorg really doesn't like xlocale disabled.
# $(use_enable nls xlocale)
