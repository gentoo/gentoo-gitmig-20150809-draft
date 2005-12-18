# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xcursor-themes/xcursor-themes-1.0.0.ebuild,v 1.1 2005/12/18 00:13:06 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org cursors data"
KEYWORDS="~amd64 ~mips ~ppc ~sh ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXcursor
	=media-libs/libpng-1.2*"
DEPEND="${RDEPEND}
	x11-apps/xcursorgen"
