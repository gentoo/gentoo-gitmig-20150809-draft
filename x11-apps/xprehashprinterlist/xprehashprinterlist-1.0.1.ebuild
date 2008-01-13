# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xprehashprinterlist/xprehashprinterlist-1.0.1.ebuild,v 1.6 2008/01/13 09:36:00 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Recomputes the list of available printers."
KEYWORDS="arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXp"
DEPEND="${RDEPEND}"
