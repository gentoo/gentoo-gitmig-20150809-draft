# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/rgb/rgb-0.99.0-r1.ebuild,v 1.3 2005/08/20 22:36:27 lu_zero Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

PATCHES="${FILESDIR}/rgb-path.patch"

DESCRIPTION="X.Org rgb application"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXt"
DEPEND="${RDEPEND}"
