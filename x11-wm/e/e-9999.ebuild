# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/e/e-9999.ebuild,v 1.4 2006/07/16 05:28:27 vapier Exp $

ECVS_MODULE="e17/apps/e"
inherit enlightenment

DESCRIPTION="the e17 window manager"

DEPEND="sys-devel/libtool
	x11-libs/evas
	x11-libs/ecore
	media-libs/edje
	dev-libs/eet
	dev-libs/embryo
	x11-libs/evas"

pkg_setup() {
	if ! built_with_use media-libs/evas png ; then
		eerror "Re-emerge evas with USE=png"
		die "Re-emerge evas with USE=png"
	fi
	enlightenment_pkg_setup
}

src_install() {
	enlightenment_src_install
	mv "${D}"/usr/bin/enlightenment{,-0.17}
}

pkg_postinst() {
	ewarn "This version has been installed as"
	ewarn "'enlightenment-0.17' to avoid conflict"
	ewarn "with enlightenment 0.16 versions."
}
