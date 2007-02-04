# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsetpointer/xsetpointer-1.0.0.ebuild,v 1.9 2007/02/04 18:34:28 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="set an X Input device as the main pointer"

KEYWORDS="alpha amd64 arm mips ppc ppc64 s390 sh sparc x86"

RDEPEND="x11-libs/libXi
	x11-libs/libX11"
DEPEND="${RDEPEND}"
