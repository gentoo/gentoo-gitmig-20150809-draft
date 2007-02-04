# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-misc-ethiopic/font-misc-ethiopic-1.0.0.ebuild,v 1.9 2007/02/04 18:44:31 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

FONT_DIR="TTF OTF"

inherit x-modular

DESCRIPTION="Miscellaneous Ethiopic fonts"
KEYWORDS="~amd64 arm ~hppa ia64 m68k ~ppc ppc64 s390 sh ~sparc ~x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	>=media-fonts/font-util-0.99.2"

CONFIGURE_OPTIONS="--with-mapfiles=${XDIR}/share/fonts/util
	--with-ttf-fontdir=/usr/share/fonts/TTF
	--with-otf-fontdir=/usr/share/fonts/OTF"
