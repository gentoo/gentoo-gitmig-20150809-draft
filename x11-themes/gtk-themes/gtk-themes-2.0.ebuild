# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="Some nice themes for GTK+ 2"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86"

BASE_URI="http://download.freshmeat.net/themes/"
SRC_URI="${BASE_URI}aqualightblue-gtk2/aqualightblue-gtk2-default.tar.gz
	${BASE_URI}bumblebee-gtk2/bumblebee-gtk2-default-1.5.tar.gz
	${BASE_URI}gnububble/gnububble-default-0.2.tar.gz
	${BASE_URI}prettyokayish-prion/prettyokayish-prion-default.tar.gz
	${BASE_URI}thinandmild/thinandmild-default.tar.gz"
	

HOMEPAGE="http://themes.freshmeat.net/"

DEPEND=">=x11-themes/gtk-engines-cleanice-1.1.5
	>=x11-themes/gtk-engines-crux-1.9.3
	>=x11-themes/gtk-engines-metal-1.9.0
	>=x11-themes/gtk-engines-mgicchikn-1.0.0
	>=x11-themes/gtk-engines-pixbuf-1.9.0
	>=x11-themes/gtk-engines-redmond95-1.9.0
	>=x11-themes/gtk-engines-thinice-2.0.1
	>=x11-themes/gtk-engines-xfce-2.0.8"

src_unpack() {
	return 0
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/share/themes
	cd ${D}/usr/share/themes

	unpack ${A}
	chmod -R ugo=rX *
}

