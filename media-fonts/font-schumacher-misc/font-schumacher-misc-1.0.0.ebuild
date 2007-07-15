# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-schumacher-misc/font-schumacher-misc-1.0.0.ebuild,v 1.13 2007/07/15 05:13:09 mr_bones_ Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Schumacher fonts"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	>=media-fonts/font-util-0.99.2"

CONFIGURE_OPTIONS="--with-mapfiles=${XDIR}/share/fonts/util"
