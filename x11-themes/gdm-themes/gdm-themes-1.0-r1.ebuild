# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gdm-themes/gdm-themes-1.0-r1.ebuild,v 1.1 2003/05/04 22:32:49 mksoft Exp $

DESCRIPTION="Some nice themes for the GDM Greeter"
S=${WORKDIR}
THEME_URI="http://ftp.gnome.org/pub/GNOME/teams/art.gnome.org/themes/gdm_greeter/"
SRC_URI="${THEME_URI}GDM-300-lantueno.tar.gz
	${THEME_URI}GDM-AMD.tar.gz
	${THEME_URI}GDM-Angel.tar.gz
	${THEME_URI}GDM-Blueish.tar.gz
	${THEME_URI}GDM-Cracked-Windows.tar.gz
	${THEME_URI}GDM-Crystal.tar.gz
	${THEME_URI}GDM-Dawn.tar.gz
	${THEME_URI}GDM-DartFrog.tar.bz2
	${THEME_URI}GDM-DumbCloud.tar.gz
	${THEME_URI}GDM-Dune.tar.gz
	${THEME_URI}GDM-Emo-Blue.tar.gz
	${THEME_URI}GDM-Flowers.tar.gz
	${THEME_URI}GDM-GlassFoot.tar.gz
	${THEME_URI}GDM-Guiss.tar.gz
	${THEME_URI}GDM-Herr_der_Ringe.tar.gz
	${THEME_URI}GDM-Hunter.tar.gz
	${THEME_URI}GDM-Jeri_Sunset.tar.gz
	${THEME_URI}GDM-Moriagate.tar.gz
	${THEME_URI}GDM-Morning.tar.bz2
	${THEME_URI}GDM-Mushu.tar.gz
	${THEME_URI}GDM-Rome.tar.gz
	${THEME_URI}GDM-Sea.tar.gz
	${THEME_URI}GDM-Segovia.tar.gz
	${THEME_URI}GDM-Segovia-Night.tar.gz
	${THEME_URI}GDM-Spiderman.tar.gz
	${THEME_URI}GDM-STGO.tar.gz
	${THEME_URI}GDM-SUSE.tar.gz
	${THEME_URI}GDM-Thrall-1.0.tar.gz
	${THEME_URI}GDM-xpto.tar.gz
	mirror://gentoo/GDM-gentoo-emergance_2.tar.gz"

HOMEPAGE="http://art.gnome.org/theme_list.php?category=gdm_greeter"

RDEPEND="gnome-base/gdm"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	return 0
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/share/gdm/themes
	cd ${D}/usr/share/gdm/themes

	unpack ${A}
	
	chmod -R ugo=rX *
}
