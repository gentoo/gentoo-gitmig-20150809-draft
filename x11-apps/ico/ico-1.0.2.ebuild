# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/ico/ico-1.0.2.ebuild,v 1.5 2010/02/25 07:09:15 abcd Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="animate an icosahedron or other polyhedron"
KEYWORDS="arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~x86-linux"
IUSE=""
RDEPEND=">=x11-libs/libX11-0.99.1_pre0"
DEPEND="${RDEPEND}"
