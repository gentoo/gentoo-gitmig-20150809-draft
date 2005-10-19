# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/util-macros/util-macros-0.99.0_p20051007.ebuild,v 1.2 2005/10/19 04:12:46 geoman Exp $

inherit versionator

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

# Fix ${S} in x-modular for pre ebuilds
MY_P="${PN}-$(get_version_component_range 1-3)"
S="${WORKDIR}/${MY_P}"

inherit x-modular

# Snapshots don't reside on fdo servers
SRC_URI="http://dev.gentoo.org/~joshuabaergen/distfiles/${P}.tar.bz2
		mirror://gentoo/${P}.tar.bz2"

DESCRIPTION="X.Org autotools utility macros"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}"
