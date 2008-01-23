# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-misc-meltho/font-misc-meltho-1.0.0.ebuild,v 1.12 2008/01/23 18:08:42 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

FONT_DIR="OTF"

inherit x-modular

DESCRIPTION="X.Org Syriac fonts"

KEYWORDS="~alpha ~amd64 arm ~hppa ia64 m68k ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	>=media-fonts/font-util-0.99.2"

CONFIGURE_OPTIONS="--with-mapfiles=${XDIR}/share/fonts/util"
