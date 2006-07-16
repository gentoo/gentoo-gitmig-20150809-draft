# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdriinfo/xdriinfo-1.0.1.ebuild,v 1.8 2006/07/16 16:44:02 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xdriinfo application"
RESTRICT="mirror"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
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
