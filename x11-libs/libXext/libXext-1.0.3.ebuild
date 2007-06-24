# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXext/libXext-1.0.3.ebuild,v 1.8 2007/06/24 22:36:53 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xext library"

KEYWORDS="~alpha amd64 arm hppa ia64 mips ~ppc ppc64 s390 sh ~sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libX11
	x11-proto/xextproto"
DEPEND="${RDEPEND}
	x11-proto/xproto"
