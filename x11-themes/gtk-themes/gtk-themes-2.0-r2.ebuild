# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-themes/gtk-themes-2.0-r2.ebuild,v 1.4 2003/10/14 22:12:13 liquidx Exp $

DESCRIPTION="Some nice themes for GTK+ 2"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ~ppc ~alpha"

BASE_URI="http://download.freshmeat.net/themes/"
BASE_URI2="http://ftp.gnome.org/pub/GNOME/teams/art.gnome.org/themes/gtk2/"
SRC_URI="${BASE_URI}aqualightblue-gtk2/aqualightblue-gtk2-default.tar.gz
	${BASE_URI}bumblebee-gtk2/bumblebee-gtk2-default-1.7.tar.gz
	${BASE_URI}candygirls/candygirls-stable-0.1.tar.gz
	${BASE_URI}fishpie/fishpie-default-0.11.tar.gz
	${BASE_URI}futuresplash/futuresplash-stable-0.1.tar.gz
	${BASE_URI}gnuaquase/gnuaquase-default-0.3.tar.gz
	${BASE_URI}gnububble/gnububble-default-0.2.tar.gz
	${BASE_URI}prettyokayish-prion/prettyokayish-prion-default.tar.gz
	${BASE_URI}thinandmild/thinandmild-default.tar.gz
	${BASE_URI2}GTK2-Funklor-0.2.tar.gz
	${BASE_URI2}GTK2-GitM.tar.gz
	${BASE_URI2}h2o-gtk2-default-1.0.tar.gz"


HOMEPAGE="http://themes.freshmeat.net/ http://art.gnome.org/"

DEPEND=">=x11-themes/gtk-engines-cleanice-1.1.5
	>=x11-themes/gtk-engines-lighthouseblue-0.4.2
	>=x11-themes/gtk-engines-magicchicken-1
	>=x11-themes/gtk-engines-mist-0.10
	>=x11-themes/gtk-engines-2.0
	>=x11-themes/gtk-engines-thinice-2.0.2-r1
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

