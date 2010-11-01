# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdriinfo/xdriinfo-1.0.3.ebuild,v 1.12 2010/11/01 12:54:47 scarabeus Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="query configuration information of DRI drivers"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	virtual/opengl"
DEPEND="${RDEPEND}
	app-admin/eselect-opengl
	x11-proto/glproto"

pkg_setup() {
	OLD_IMPLEM="$(eselect opengl show)"

	if [[ ${OLD_IMPLEM} != xorg-x11 ]]; then
		# Bug #138920
		ewarn "Forcing on xorg-x11 for header sanity..."
		einfo "If compilation fails run:"
		einfo "# eselect opengl set ${OLD_IMPLEM}"
		eselect opengl set xorg-x11
	fi
}

pkg_postinst() {
	[[ ${OLD_IMPLEM} != xorg-x11 ]] && eselect opengl set ${OLD_IMPLEM}
}
