# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.5.6_p20050903.ebuild,v 1.1 2005/09/08 22:25:19 joshuabaergen Exp $

inherit versionator

# Fix ${S} in x-modular for pre ebuilds
MY_P="${PN}-$(get_version_component_range 1-3)"
S="${WORKDIR}/${MY_P}"

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

# Snapshots don't reside on fdo servers
SRC_URI="mirror://gentoo/${P}.tar.bz2"

DESCRIPTION="X.Org driver for ati cards"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="dri"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto )"

CONFIGURE_OPTIONS="$(use_enable dri)"

pkg_setup() {
	if use dri && ! built_with_use x11-base/xorg-server dri; then
		die "Build x11-base/xorg-server with USE=dri."
	fi
}
