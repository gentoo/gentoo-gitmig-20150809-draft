# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/oclock/oclock-1.0.1.ebuild,v 1.4 2006/09/05 23:02:32 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org oclock application"
KEYWORDS="alpha amd64 arm mips ppc ppc64 ~s390 sh sparc x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXext"
DEPEND="${RDEPEND}"
