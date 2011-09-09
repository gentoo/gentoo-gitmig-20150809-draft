# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/faenza-icon-theme/faenza-icon-theme-1.0.ebuild,v 1.2 2011/09/09 14:04:56 scarabeus Exp $

EAPI="4"

inherit gnome2-utils

DESCRIPTION="A scalable icon theme called Faenza"
HOMEPAGE="http://code.google.com/p/faenza-icon-theme/"
SRC_URI="http://faenza-icon-theme.googlecode.com/files/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( x11-themes/gnome-icon-theme )
	x11-themes/hicolor-icon-theme"

RESTRICT="binchecks strip"

S=${WORKDIR}

src_prepare() {
	for x in Faenza Faenza-Dark; do
		for res in 22 24 32 48; do
			cp "${x}"/places/${res}/start-here-gentoo.png \
				"${x}"/places/${res}/start-here.png || die
		done
		cp "${x}"/places/scalable/start-here-gentoo.svg \
			"${x}"/places/scalable/start-here.svg ||die
	done
}

src_install() {
	insinto /usr/share/icons
	doins -r Faenza{,-Dark,-Darker,-Darkest}

	dodoc AUTHORS ChangeLog README
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
