# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-misc-meltho/font-misc-meltho-1.0.0.ebuild,v 1.4 2006/03/24 03:52:52 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

FONT_DIR="OTF"

inherit x-modular

DESCRIPTION="BigReqs prototype headers"
RESTRICT="mirror"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	>=media-fonts/font-util-0.99.2"

CONFIGURE_OPTIONS="--with-mapfiles=${XDIR}/share/fonts/util"
