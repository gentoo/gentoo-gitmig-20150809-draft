# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xf86dga/xf86dga-1.0.2.ebuild,v 1.10 2009/05/05 07:52:50 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="test program for the XFree86-DGA extension"
KEYWORDS="amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXxf86dga"
DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto"
