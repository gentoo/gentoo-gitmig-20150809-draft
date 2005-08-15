# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mkfontdir/mkfontdir-0.99.0.ebuild,v 1.3 2005/08/15 17:52:42 herbs Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org mkfontdir application"
KEYWORDS="~amd64 ~sparc ~x86"
RDEPEND="x11-apps/mkfontscale"
DEPEND="${RDEPEND}"
