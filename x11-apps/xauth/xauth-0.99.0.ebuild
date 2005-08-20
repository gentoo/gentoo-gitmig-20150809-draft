# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xauth/xauth-0.99.0.ebuild,v 1.4 2005/08/20 22:28:06 lu_zero Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xauth application"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXext
	x11-libs/libXmu"
DEPEND="${RDEPEND}"
