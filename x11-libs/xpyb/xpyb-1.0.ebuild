# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xpyb/xpyb-1.0.ebuild,v 1.3 2009/12/14 11:15:52 remi Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="XCB-based Python bindings for the X Window System"
HOMEPAGE="http://xcb.freedesktop.org/"
SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
IUSE="selinux"
RDEPEND=">=x11-libs/libxcb-1.1
	>=dev-lang/python-2.5"
DEPEND="${RDEPEND}
	>=x11-proto/xcb-proto-1.2"
DOCS="NEWS README"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable selinux xselinux)"
}
