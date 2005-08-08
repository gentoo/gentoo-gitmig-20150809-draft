# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smoothgnome/smoothgnome-2.0.4.ebuild,v 1.1 2005/08/08 13:13:12 leonardop Exp $

inherit gnome2

MY_PN="SmoothGNOME"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A GNOME theme designed to make a nicer default looking desktop"
HOMEPAGE="http://web.subpop.net/art/smoothgnome/"
SRC_URI="http://web.subpop.net/art/${PN}/releases/2/GTK2-${MY_P}.tar.gz
	http://web.subpop.net/art/${PN}/releases/2/ICON-${MY_P}.tar.gz
	http://web.subpop.net/art/${PN}/releases/2/MCity-${MY_P}.tar.gz
	http://web.subpop.net/art/${PN}/releases/2/GTK2-${MY_PN}-Extras-${PV}.tar.gz"

KEYWORDS="~x86"
LICENSE="as-is"
SLOT="0"
IUSE="gtk2"

DEPEND=""
RDEPEND="gtk2? ( >=x11-themes/gtk-engines-2 )
	!gtk2? ( x11-themes/gtk-engines-smooth )"

src_unpack() {
	unpack GTK2-${MY_P}.tar.gz
	unpack GTK2-${MY_PN}-Extras-${PV}.tar.gz
	unpack MCity-${MY_P}.tar.gz

	mkdir icons; cd icons
	unpack ICON-${MY_P}.tar.gz
}

src_compile() {
	return
}

src_install() {
	cd ${WORKDIR}
	for dir in SmoothGNOME* ; do
		insinto /usr/share/themes/${dir}
		doins -r ${dir}/*
	done

	insinto /usr/share/icons
	doins -r icons/*
}
