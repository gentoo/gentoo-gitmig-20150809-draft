# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxcb/libxcb-1.0.ebuild,v 1.5 2007/03/22 17:58:15 gustavoz Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X C-language Bindings library"
SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"
LICENSE="X11"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
RDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=x11-proto/xcb-proto-1.0"
