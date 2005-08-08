# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkbdata/xkbdata-0.99.0.ebuild,v 1.2 2005/08/08 22:48:35 fmccor Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xkbdata data"
KEYWORDS="~sparc ~x86"
RDEPEND="x11-apps/xkbcomp"
DEPEND="${RDEPEND}"
