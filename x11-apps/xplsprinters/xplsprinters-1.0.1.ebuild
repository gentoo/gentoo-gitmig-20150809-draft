# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xplsprinters/xplsprinters-1.0.1.ebuild,v 1.8 2006/09/08 17:52:15 tcort Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xplsprinters application"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd"
RDEPEND="x11-libs/libX11
	x11-libs/libXp
	x11-libs/libXprintUtil"
DEPEND="${RDEPEND}"
