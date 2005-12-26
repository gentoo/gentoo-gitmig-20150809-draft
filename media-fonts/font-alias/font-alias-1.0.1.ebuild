# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-alias/font-alias-1.0.1.ebuild,v 1.2 2005/12/26 10:26:49 stefaan Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontscale"

CONFIGURE_OPTIONS="--with-top-fontdir=/usr/share/fonts"
