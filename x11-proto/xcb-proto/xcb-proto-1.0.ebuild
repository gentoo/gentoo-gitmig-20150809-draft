# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xcb-proto/xcb-proto-1.0.ebuild,v 1.2 2006/11/24 15:34:06 flameeyes Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X C-language Bindings protocol headers"
SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"
LICENSE="X11"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}
	dev-libs/libxml2"
