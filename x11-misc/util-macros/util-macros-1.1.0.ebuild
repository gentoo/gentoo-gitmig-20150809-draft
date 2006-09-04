# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/util-macros/util-macros-1.1.0.ebuild,v 1.7 2006/09/04 07:11:15 kumba Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org autotools utility macros"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}"

PATCHES="${FILESDIR}/1.1.0-driver-man-suffix.patch"
