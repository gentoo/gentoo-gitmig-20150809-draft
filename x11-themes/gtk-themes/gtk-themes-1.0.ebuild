# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="Some nice themes for GTK+"
LICENSE="GPL-2"
SLOT="1"
S=${WORKDIR}
KEYWORDS="x86"

BASE_URI="http://download.freshmeat.net/themes/"
SRC_URI="${BASE_URI}3000_xeno/3000_xeno-1.1.tar.gz
	${BASE_URI}4missy/4missy-1.2.x.tar.gz
	${BASE_URI}absoluteegtk/absoluteegtk-default.tar.gz
	${BASE_URI}adeptpremier/adeptpremier-1.2.x.tar.gz
	${BASE_URI}aquagraphite/aquagraphite-1.2.x.tar.gz
	${BASE_URI}aquaxen/aquaxen-1.2.x.tar.gz
	${BASE_URI}arcticpixmap/arcticpixmap-1.2.x.tar.gz
	${BASE_URI}beos/beos-1.2.tar.gz
	${BASE_URI}blackbox__/blackbox__-1.2.3.tar.gz
	${BASE_URI}bluecosm/bluecosm-1.2.x.tar.gz
	${BASE_URI}bluegnome/bluegnome-1.2.3.tar.gz
	${BASE_URI}blueheartgtk/blueheartgtk-1.2.x.tar.gz
	${BASE_URI}bluesteel_/bluesteel_-1.2.tar.gz
	${BASE_URI}darkmarble/darkmarble-1.2.1.tar.gz
	${BASE_URI}eazelblue_/eazelblue_-1.2.x.tar.gz
	${BASE_URI}elegance/elegance-1.2.tar.gz
	${BASE_URI}emeraldcity/emeraldcity-1.2.tar.gz
	${BASE_URI}eslate_/eslate_-1.2.x.tar.gz
	${BASE_URI}etech_hydro_gtk/etech_hydro_gtk-1.2.x.tar.gz
	${BASE_URI}ganymede__/ganymede__-1.2.x.tar.gz
	${BASE_URI}gnomelook/gnomelook-1.2.x.tar.gz
	${BASE_URI}gnugget/gnugget-1.2.tar.gz
	${BASE_URI}gradientblue_/gradientblue_-1.2.1.tar.gz
	${BASE_URI}gtksteppastel/gtksteppastel-1.2.x.tar.gz
	${BASE_URI}irex_/irex_-1.2.x.tar.gz
	${BASE_URI}macosblue86/macosblue86-1.2.tar.gz
	${BASE_URI}marble3d/marble3d-1.2.3.tar.gz
	${BASE_URI}matrix_green_/matrix_green_-1.2.x.tar.gz
	${BASE_URI}minegtk/minegtk-1.2.3.tar.gz
	${BASE_URI}morphiusx_/morphiusx_-1.2.tar.gz
	${BASE_URI}mozillamodern/mozillamodern-1.1.tar.gz
	${BASE_URI}ojgtk/ojgtk-default-1.0.tar.gz
	${BASE_URI}osx2/osx2-1.2.x.tar.gz
	${BASE_URI}qnxphoton/qnxphoton-1.2.tar.gz
	${BASE_URI}shinymetal/shinymetal-1.2.tar.gz
	${BASE_URI}solariscde/solariscde-1.2.x.tar.gz
	${BASE_URI}spiffgtk/spiffgtk-1.2.3.tar.gz
	${BASE_URI}sunshine-gtk/sunshine-gtk-0.1.tar.gz
	${BASE_URI}thinskismoke/thinskismoke-1.2.3.tar.gz
	${BASE_URI}whistlerk/whistlerk-1.2.x.tar.gz
	${BASE_URI}wireframe_/wireframe_-1.2.x.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/"

DEPEND="=x11-themes/gtk-engines-begtk-1.0.1*
	=x11-themes/gtk-engines-cleanice-0.8.5*
	=x11-themes/gtk-engines-eazel-0.3*
	=x11-themes/gtk-engines-flat-0.1*
	=x11-themes/gtk-engines-gtkstep-2.2*
	=x11-themes/gtk-engines-icegradient-0.0.5*
	=x11-themes/gtk-engines-mac2-1.0.3*
	=x11-themes/gtk-engines-metal-0.12*
	=x11-themes/gtk-engines-notif-0.12*
	=x11-themes/gtk-engines-pixmap-0.12*
	=x11-themes/gtk-engines-raleigh-0.12*
	=x11-themes/gtk-engines-redmond95-0.12*
	=x11-themes/gtk-engines-thinice-1.0.4*
	=x11-themes/gtk-engines-xenophilia-0.8*"

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

