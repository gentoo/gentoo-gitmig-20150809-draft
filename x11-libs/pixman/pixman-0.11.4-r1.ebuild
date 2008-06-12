# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pixman/pixman-0.11.4-r1.ebuild,v 1.1 2008/06/12 14:56:11 cardoe Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

PATCHES="${FILESDIR}/${PN}-0.11.4-memleak.patch"

inherit x-modular

DESCRIPTION="Low-level pixel manipulation routines"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
