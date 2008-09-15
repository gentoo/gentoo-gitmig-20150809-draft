# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/x11perf/x11perf-1.5.ebuild,v 1.2 2008/09/15 02:18:50 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="summarize x11perf results"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXft"
DEPEND="${RDEPEND}"
