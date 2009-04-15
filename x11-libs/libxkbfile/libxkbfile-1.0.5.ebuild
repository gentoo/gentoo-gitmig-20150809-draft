# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxkbfile/libxkbfile-1.0.5.ebuild,v 1.7 2009/04/15 14:36:22 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xkbfile library"

KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~m68k ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libX11
	x11-proto/kbproto"
DEPEND="${RDEPEND}"
