# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fonttosfnt/fonttosfnt-1.0.3.ebuild,v 1.2 2007/12/19 23:47:08 cla Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org fonttosfnt application"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
RDEPEND="x11-libs/libX11
	=media-libs/freetype-2*
	x11-libs/libfontenc"
DEPEND="${RDEPEND}"
