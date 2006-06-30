# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xset/xset-1.0.2.ebuild,v 1.3 2006/06/30 18:16:47 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xset application"
KEYWORDS="amd64 ~arm ~mips ~ppc ppc64 ~s390 ~sparc x86 ~x86-fbsd"
RDEPEND="x11-libs/libXmu"
DEPEND="${RDEPEND}"
