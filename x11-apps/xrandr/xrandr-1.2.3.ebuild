# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xrandr/xrandr-1.2.3.ebuild,v 1.8 2009/04/16 02:09:37 jer Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="primitive command line interface to RandR extension"

KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"

RDEPEND=">=x11-libs/libXrandr-1.2
	x11-libs/libX11"
DEPEND="${RDEPEND}"
