# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsetroot/xsetroot-0.99.0.ebuild,v 1.4 2005/09/06 17:48:28 herbs Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xsetroot application"
KEYWORDS="~amd64 ~arm ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXmu
	x11-libs/libX11"
DEPEND="${RDEPEND}"
