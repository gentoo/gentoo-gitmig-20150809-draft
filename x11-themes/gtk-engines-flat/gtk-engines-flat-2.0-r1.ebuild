# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-flat/gtk-engines-flat-2.0-r1.ebuild,v 1.9 2004/08/18 15:27:04 kugelfang Exp $

inherit gtk-engines2 gnuconfig

MY_PN=${PN/gtk-engines-flat/gtk-flat-theme}

IUSE=""
DESCRIPTION="GTK+1 and GTK+2 Flat Theme Engine"
SRC_URI="mirror://gnome/teams/art.gnome.org/themes/gtk/Flat-1.2.x.tar.gz
	http://download.freshmeat.net/themes/gtk2flat/gtk2flat-default.tar.gz"
HOMEPAGE="http://art.gnome.org/show_theme.php?themeID=56&category=gtk
	http://themes.freshmeat.net/projects/gtk2flat/"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
LICENSE="GPL-2"
SLOT="2"

GTK1_S=${WORKDIR}/${MY_PN}-0.1
GTK2_S=${WORKDIR}/${MY_PN}-2.0

src_unpack() {
	unpack ${A}
	if [[ ${ARCH} == "amd64" ]]; then
		gnuconfig_update ${WORKDIR}
	fi
}
