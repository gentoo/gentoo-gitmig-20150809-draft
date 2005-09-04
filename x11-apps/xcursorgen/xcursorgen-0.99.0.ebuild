# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xcursorgen/xcursorgen-0.99.0.ebuild,v 1.6 2005/09/04 08:19:18 matsuu Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xcursorgen application"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXcursor
	=media-libs/libpng-1.2*"
DEPEND="${RDEPEND}"
