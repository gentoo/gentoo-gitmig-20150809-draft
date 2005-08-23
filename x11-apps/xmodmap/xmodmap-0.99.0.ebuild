# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xmodmap/xmodmap-0.99.0.ebuild,v 1.3 2005/08/23 12:25:14 herbs Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xwud application"
KEYWORDS="~amd64 ~sparc ~x86"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
