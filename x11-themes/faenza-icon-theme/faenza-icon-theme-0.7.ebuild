# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/faenza-icon-theme/faenza-icon-theme-0.7.ebuild,v 1.4 2011/01/26 16:52:26 ssuominen Exp $

inherit gnome2-utils

DESCRIPTION="A scalable icon theme called Faenza"
HOMEPAGE="http://tiheum.deviantart.com/art/Faenza-Icons-173323228"
SRC_URI="mirror://gentoo/Faenza_Icons_by_tiheum.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="minimal"

RDEPEND="!minimal? ( x11-themes/gnome-icon-theme )"
DEPEND="app-arch/unzip"

RESTRICT="binchecks strip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack ./Faenza.tar.gz
	unpack ./Faenza-Dark.tar.gz
	unpack ./emesene-faenza-theme.tar.gz
}

src_install() {
	insinto /usr/share/icons
	doins -r Faenza{,-Dark} || die

	insinto /usr/share/themes
	doins -r emesene/themes/Faenza{,-Dark} || die

	dodoc AUTHORS ChangeLog README
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
