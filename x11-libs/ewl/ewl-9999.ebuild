# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ewl/ewl-9999.ebuild,v 1.11 2006/08/08 15:32:55 vapier Exp $

inherit enlightenment

DESCRIPTION="simple-to-use general purpose widget library"

IUSE="X fbcon opengl"

RDEPEND=">=media-libs/edje-0.5.0
	>=dev-db/edb-1.0.5
	>=x11-libs/evas-0.9.9
	>=x11-libs/ecore-0.9.9"
DEPEND="${RDEPEND}
	doc? ( app-text/tetex )"

pkg_setup() {
	if ! built_with_use x11-libs/evas png ; then
		eerror "Re-emerge evas with USE=png"
		die "Re-emerge evas with USE=png"
	fi
	enlightenment_pkg_setup
}

src_compile() {
	export MY_ECONF="
		$(use_enable X software-x11)
		$(use_enable opengl opengl-x11)
		$(use_enable fbcon)
	"
	enlightenment_src_compile
}
