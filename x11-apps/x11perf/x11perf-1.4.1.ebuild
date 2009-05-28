# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/x11perf/x11perf-1.4.1.ebuild,v 1.14 2009/05/28 17:06:32 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="summarize x11perf results"
KEYWORDS="~alpha amd64 arm mips ppc ppc64 s390 sh sparc x86"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXft"
DEPEND="${RDEPEND}"
