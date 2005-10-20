# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ewl/ewl-9999.ebuild,v 1.8 2005/10/20 05:38:47 vapier Exp $

inherit enlightenment

DESCRIPTION="simple-to-use general purpose widget library"

IUSE="X fbcon opengl"

DEPEND=">=media-libs/edje-0.5.0
	>=dev-db/edb-1.0.5
	>=x11-libs/evas-0.9.9
	>=x11-libs/ecore-0.9.9"

pkg_setup() {
	if ! built_with_use media-libs/edje png ; then
		eerror "Re-emerge edje with USE=png"
		die "Re-emerge edje with USE=png"
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
