# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/imake/imake-0.99.3.ebuild,v 1.1 2005/12/04 23:13:40 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org imake build system"
KEYWORDS="~amd64 ~mips ~sparc ~x86"
RDEPEND="x11-misc/xorg-cf-files"
DEPEND="${RDEPEND}
		x11-proto/xproto"

PATCHES=""
