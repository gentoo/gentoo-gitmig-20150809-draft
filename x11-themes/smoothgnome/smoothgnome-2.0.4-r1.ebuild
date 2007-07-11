# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smoothgnome/smoothgnome-2.0.4-r1.ebuild,v 1.6 2007/07/11 02:54:47 leio Exp $

inherit gnome2

MY_PN="SmoothGNOME"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A GNOME theme designed to make a nicer default looking desktop"
HOMEPAGE="http://web.subpop.net/art/smoothgnome/"
SRC_URI="http://web.subpop.net/art/${PN}/releases/2/GTK2-${MY_P}.tar.gz
	http://web.subpop.net/art/${PN}/releases/2/ICON-${MY_P}.tar.gz
	http://web.subpop.net/art/${PN}/releases/2/MCity-${MY_P}.tar.gz
	http://web.subpop.net/art/${PN}/releases/2/GTK2-${MY_PN}-Extras-${PV}.tar.gz"

KEYWORDS="ppc sparc x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=x11-themes/gtk-engines-2"

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
	cd "${WORKDIR}"
	for dir in SmoothGNOME* ; do
		insinto /usr/share/themes/${dir}
		doins -r ${dir}/*
	done

	insinto /usr/share/icons
	doins -r icons/*
}
