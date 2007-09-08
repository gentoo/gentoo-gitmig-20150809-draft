# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXtst/libXtst-1.0.2.ebuild,v 1.5 2007/09/08 21:18:39 josejx Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xtst library"

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 s390 sh ~sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libX11
	x11-proto/recordproto
	x11-libs/libXext"
DEPEND="${RDEPEND}"
