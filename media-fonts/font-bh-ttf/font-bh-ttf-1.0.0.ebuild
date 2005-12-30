# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bh-ttf/font-bh-ttf-1.0.0.ebuild,v 1.2 2005/12/30 02:23:46 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig
	x11-apps/ttmkfdir"
