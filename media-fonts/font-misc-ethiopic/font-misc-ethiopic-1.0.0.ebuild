# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-misc-ethiopic/font-misc-ethiopic-1.0.0.ebuild,v 1.6 2006/07/11 15:20:01 agriffis Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

FONT_DIR="TTF OTF"

inherit x-modular

DESCRIPTION="Miscellaneous Ethiopic fonts"
RESTRICT="mirror"
KEYWORDS="~amd64 ~arm ~hppa ia64 ~ppc ppc64 ~s390 ~sh ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	>=media-fonts/font-util-0.99.2"

CONFIGURE_OPTIONS="--with-mapfiles=${XDIR}/share/fonts/util
	--with-ttf-fontdir=/usr/share/fonts/TTF
	--with-otf-fontdir=/usr/share/fonts/OTF"
