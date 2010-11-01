# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/ico/ico-1.0.3.ebuild,v 1.1 2010/11/01 14:49:16 scarabeus Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="animate an icosahedron or other polyhedron"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-linux"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
