# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXfontcache/libXfontcache-1.0.3.ebuild,v 1.1 2006/10/22 18:02:42 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xfontcache library"

KEYWORDS="~alpha ~amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/fontcacheproto"
