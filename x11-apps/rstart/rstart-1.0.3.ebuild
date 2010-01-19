# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/rstart/rstart-1.0.3.ebuild,v 1.9 2010/01/19 18:15:51 armin76 Exp $

# Must be before x-modular eclass is inherited
# Hack to make autoreconf run for our patch
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org rstart application"
KEYWORDS="amd64 arm ~mips ppc ppc64 s390 sh ~sparc x86"
IUSE=""
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
