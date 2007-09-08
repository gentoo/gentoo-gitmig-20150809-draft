# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdriinfo/xdriinfo-1.0.2.ebuild,v 1.1 2007/09/08 06:13:24 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="query configuration information of DRI drivers"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
RDEPEND="x11-libs/libX11
	virtual/opengl"
DEPEND="${RDEPEND}
	app-admin/eselect-opengl
	x11-proto/glproto"

pkg_setup() {
	# Bug #138920
	ewarn "Forcing on xorg-x11 for header sanity..."
	OLD_IMPLEM="$(eselect opengl show)"
	eselect opengl set --impl-headers xorg-x11
}

pkg_postinst() {
	echo
	eselect opengl set ${OLD_IMPLEM}
}
