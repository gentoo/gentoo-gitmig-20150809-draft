# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xauth/xauth-1.0.3.ebuild,v 1.7 2009/04/15 14:48:30 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X authority file utility"

KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
IUSE="ipv6"

RDEPEND="x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXext
	x11-libs/libXmu"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
