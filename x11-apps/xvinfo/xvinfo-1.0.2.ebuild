# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xvinfo/xvinfo-1.0.2.ebuild,v 1.4 2008/01/21 14:24:15 drac Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Print out X-Video extension adaptor information"

KEYWORDS="amd64 arm ~hppa ~mips ~ppc ~ppc64 s390 sh ~sparc x86"

RDEPEND="x11-libs/libXv
	x11-libs/libX11"
DEPEND="${RDEPEND}"
