# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsetpointer/xsetpointer-1.0.1.ebuild,v 1.13 2010/10/23 23:11:13 leio Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="set an X Input device as the main pointer"

KEYWORDS="alpha amd64 arm hppa ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="x11-libs/libXi
	x11-libs/libX11"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-1.4"
