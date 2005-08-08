# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xfd/xfd-0.99.0.ebuild,v 1.2 2005/08/08 20:14:19 fmccor Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xfd application"
KEYWORDS="~sparc ~x86"
# xprint support isn't optional, despite what configure says.
#IUSE="xprint"
RDEPEND="=media-libs/freetype-2*
	media-libs/fontconfig
	x11-libs/libXft
	x11-libs/libXaw"
DEPEND="${RDEPEND}"

pkg_setup() {
	if ! built_with_use x11-libs/libXaw xprint; then
		die "Build x11-libs/libXaw with USE=xprint."
	fi
}
