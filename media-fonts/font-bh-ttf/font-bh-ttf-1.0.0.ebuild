# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bh-ttf/font-bh-ttf-1.0.0.ebuild,v 1.10 2006/10/20 21:22:44 kloeri Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Bigelow & Holmes TrueType fonts"

KEYWORDS="alpha ~amd64 arm ~hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh ~sparc ~x86"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig
	x11-apps/ttmkfdir"
