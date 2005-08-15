# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/iceauth/iceauth-0.99.0.ebuild,v 1.3 2005/08/15 17:57:36 herbs Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org iceauth application"
KEYWORDS="~amd64 ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libICE"
DEPEND="${RDEPEND}"
