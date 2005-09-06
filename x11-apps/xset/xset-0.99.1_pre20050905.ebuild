# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xset/xset-0.99.1_pre20050905.ebuild,v 1.1 2005/09/06 16:06:56 joshuabaergen Exp $

inherit versionator
# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

# Fix ${S} for pre ebuilds
MY_P="${PN}-$(get_version_component_range 1-3)"
S="${WORKDIR}/${MY_P}"

inherit x-modular

DESCRIPTION="X.Org xset application"
KEYWORDS="~arm ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXmu"
DEPEND="${RDEPEND}"
