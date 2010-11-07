# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/neu-icon-theme/neu-icon-theme-0.6.ebuild,v 1.2 2010/11/07 18:02:37 ssuominen Exp $

inherit gnome2-utils

DESCRIPTION="A scalable icon theme called Neu"
HOMEPAGE="http://www.silvestre.com.ar/"
SRC_URI="http://www.silvestre.com.ar/icons/Neu-${PV}-PR3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-themes/gnome-icon-theme"
DEPEND=""

RESTRICT="binchecks strip"

S=${WORKDIR}

src_install() {
	dodoc Neu/{AUTHORS,README,TODO}
	rm -f Neu/{AUTHORS,COPYING,DONATE,INSTALL,README,TODO}

	insinto /usr/share/icons
	doins -r Neu || die
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
