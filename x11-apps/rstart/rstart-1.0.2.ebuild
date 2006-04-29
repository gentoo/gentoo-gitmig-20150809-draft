# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/rstart/rstart-1.0.2.ebuild,v 1.1 2006/04/29 16:33:44 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
# Hack to make autoreconf run for our patch
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org rstart application"
KEYWORDS="~arm ~mips ~ppc64 ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

#PATCHES="${FILESDIR}/rstart-destdir.patch"
