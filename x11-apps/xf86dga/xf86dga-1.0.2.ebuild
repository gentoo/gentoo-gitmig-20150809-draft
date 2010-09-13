# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xf86dga/xf86dga-1.0.2.ebuild,v 1.17 2010/09/13 01:01:30 josejx Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="test program for the XFree86-DGA extension"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXxf86dga"
DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto"

PATCHES=( "${FILESDIR}/xf86dga-1.0.2-fix-deps.patch" )
