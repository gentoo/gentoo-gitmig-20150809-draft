# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/imake/imake-1.0.2.ebuild,v 1.6 2006/07/03 16:38:06 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org imake build system"
RESTRICT="mirror"
KEYWORDS="alpha amd64 arm ~hppa ~ia64 mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
RDEPEND="x11-misc/xorg-cf-files
	!x11-misc/xmkmf"
DEPEND="${RDEPEND}
	x11-proto/xproto"
