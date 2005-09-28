# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xedit/xedit-0.99.0.ebuild,v 1.4 2005/09/28 02:59:41 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xedit application"
KEYWORDS="~sparc ~x86"
# As of 20050927, we should be able to make xprint optional
#IUSE="xprint"
RDEPEND="x11-libs/libXprintUtil
	x11-libs/libXaw"
#xprint? ( x11-libs/libXprintUtil )
DEPEND="${RDEPEND}"

#CONFIGURE_OPTIONS="$(use_enable xprint)"

pkg_setup() {
#	if use xprint && ! built_with_use x11-libs/libXaw xprint; then
	if ! built_with_use x11-libs/libXaw xprint; then
		die "Build x11-libs/libXaw with USE=xprint."
	fi
}

src_compile() {
	x-modular_src_configure
	emake -j1 || die "emake failed"
}
