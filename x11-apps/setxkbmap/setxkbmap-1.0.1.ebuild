# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/setxkbmap/setxkbmap-1.0.1.ebuild,v 1.5 2006/02/23 08:42:57 stefaan Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

PATCHES=""

DESCRIPTION="X.Org setxkbmap application"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
RDEPEND="x11-libs/libxkbfile
	x11-libs/libX11"
DEPEND="${RDEPEND}"
