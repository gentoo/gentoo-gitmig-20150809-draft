# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mkfontdir/mkfontdir-1.0.4.ebuild,v 1.3 2009/05/05 06:42:19 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="create an index of X font files in a directory"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"

RDEPEND="x11-apps/mkfontscale"
DEPEND="${RDEPEND}"
