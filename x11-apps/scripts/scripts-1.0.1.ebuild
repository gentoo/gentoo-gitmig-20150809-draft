# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/scripts/scripts-1.0.1.ebuild,v 1.8 2010/08/19 00:04:33 robbat2 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="start an X program on a remote machine"
KEYWORDS="arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~amd64"
IUSE=""
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
