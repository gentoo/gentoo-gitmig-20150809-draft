# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gdm-themes/gdm-themes-2.0.ebuild,v 1.3 2004/11/19 15:40:49 humpback Exp $

RESTRIC="nomirror"
DESCRIPTION="Some nice themes for the GDM Greeter"
S=${WORKDIR}
THEME_URI="http://ftp.gnome.org/pub/GNOME/teams/art.gnome.org/themes/gdm_greeter/"
SRC_URI="${THEME_URI}GDM-300-lantueno.tar.gz
	${THEME_URI}GDM-AMD.tar.gz
	${THEME_URI}GDM-Angel.tar.gz
	${THEME_URI}GDM-AppleTux.tar.gz
	${THEME_URI}GDM-AppleTuxBlack.tar.gz
	${THEME_URI}GDM-Barna.tar.gz
	${THEME_URI}GDM-Batman.tar.gz
	${THEME_URI}GDM-BeeAtWork.tar.gz
	${THEME_URI}GDM-Bijou.tgz
	${THEME_URI}GDM-BlueSlack.tar.gz
	${THEME_URI}GDM-Bluecurve.tar.gz
	${THEME_URI}GDM-Blueish.tar.gz
	${THEME_URI}GDM-Butterfly.tar.gz
	${THEME_URI}GDM-Chile.tar.gz
	${THEME_URI}GDM-Chilie.tar.gz
	${THEME_URI}GDM-Coding.tar.gz
	${THEME_URI}GDM-Cracked-Windows.tar.gz
	${THEME_URI}GDM-Cropcircles.tar.bz2
	${THEME_URI}GDM-Crystal-Rose.tar.gz
	${THEME_URI}GDM-Crystal.tar.gz
	${THEME_URI}GDM-Crystal_for_Gnome.tar.gz
	${THEME_URI}GDM-CrystalforGnome2.tar.gz
	${THEME_URI}GDM-Cubic_Linux_Gnome.tar.gz
	${THEME_URI}GDM-Darkcrystal.tar.bz2
	${THEME_URI}GDM-Dawn.tar.gz
	${THEME_URI}GDM-Daybreak.tar.gz
	${THEME_URI}GDM-DartFrog.tar.bz2
	${THEME_URI}GDM-Debian.tar.gz
	${THEME_URI}GDM-Debian2.tar.gz
	${THEME_URI}GDM-Debianlogo_0.1.tar.gz
	${THEME_URI}GDM-Delicious.tar.gz
	${THEME_URI}GDM-DevilsCandy.tar.gz
	${THEME_URI}GDM-Dreaming-Alien.tar.gz
	${THEME_URI}GDM-Dropline.tar.gz
	${THEME_URI}GDM-DumbCloud.tar.gz
	${THEME_URI}GDM-Dune.tar.gz
	${THEME_URI}GDM-Eli-Theme.zip
	${THEME_URI}GDM-Emo-Blue.tar.gz
	${THEME_URI}GDM-Falling-Angel.tar.gz
	${THEME_URI}GDM-Flame.tar.gz
	${THEME_URI}GDM-Flowers.tar.gz
	${THEME_URI}GDM-FreeBSD.tar.gz
	${THEME_URI}GDM-FreeBSDarth.tar.gz
	${THEME_URI}GDM-Gentoo-Bluebox.tar.gz
	${THEME_URI}GDM-Gentoo-Emergence.tar.gz
	${THEME_URI}GDM-GlassFoot.tar.gz
	${THEME_URI}GDM-Glassy.tar.gz
	${THEME_URI}GDM-GnomeOrange.tar.gz
	${THEME_URI}GDM-Guiss.tar.gz
	${THEME_URI}GDM-Hantzley.tar.gz
	${THEME_URI}GDM-Herr_der_Ringe.tar.gz
	${THEME_URI}GDM-Human-1.0.tar.gz
	${THEME_URI}GDM-Hunter.tar.gz
	${THEME_URI}GDM-Hybridfusion.tar.gz
	${THEME_URI}GDM-Jeri_Sunset.tar.gz
	${THEME_URI}GDM-JustBSD.tar.gz
	${THEME_URI}GDM-KDE-Crystal.tar.gz
	${THEME_URI}GDM-Kinkakuji.tar.gz
	${THEME_URI}GDM-Knoke.tar.gz
	${THEME_URI}GDM-Lenore.tar.gz
	${THEME_URI}GDM-Leon.tar.gz
	${THEME_URI}GDM-LinuxTux.tar.gz
	${THEME_URI}GDM-Linux_Crystal.tar.gz
	${THEME_URI}GDM-MachuPicchu.tar.gz
	${THEME_URI}GDM-Matrix.tar.gz
	${THEME_URI}GDM-Milk.tar.gz
	${THEME_URI}GDM-Mirrored-0.8.tar.gz
	${THEME_URI}GDM-Moebius.tar.gz
	${THEME_URI}GDM-MonoMetal.tar.gz
	${THEME_URI}GDM-Moriagate.tar.gz
	${THEME_URI}GDM-Morning.tar.bz2
	${THEME_URI}GDM-Mosaic.tar.gz
	${THEME_URI}GDM-Mozi.tar.gz
	${THEME_URI}GDM-Murcia.tgz
	${THEME_URI}GDM-Mushu.tar.gz
	${THEME_URI}GDM-Night-Elf-1.0.1.tar.gz
	${THEME_URI}GDM-Nightwish.tar.gz
	${THEME_URI}GDM-Odysseus.tar.gz
	${THEME_URI}GDM-OpenSource.tgz
	${THEME_URI}GDM-Orc-1.0.tar.gz
	${THEME_URI}GDM-RV.tar.gz
	${THEME_URI}GDM-Red-Leaves.tar.gz
	${THEME_URI}GDM-RedHat.tar.bz2
	${THEME_URI}GDM-Rome.tar.gz
	${THEME_URI}GDM-STGO.tar.gz
	${THEME_URI}GDM-SUSE.tar.gz
	${THEME_URI}GDM-Sea.tar.gz
	${THEME_URI}GDM-Segovia.tar.gz
	${THEME_URI}GDM-Segovia-Night.tar.gz
	${THEME_URI}GDM-Simple-Gnome-Logo.tar.gz
	${THEME_URI}GDM-Slacked.tar.gz
	${THEME_URI}GDM-Slackgdm.tar.gz
	${THEME_URI}GDM-Space.tar.gz
	${THEME_URI}GDM-Splinter.tar.gz
	${THEME_URI}GDM-Sunset.tar.gz
	${THEME_URI}GDM-Synergy.tar.gz
	${THEME_URI}GDM-Taipei.tar.gz
	${THEME_URI}GDM-Tcpa.tar.gz
	${THEME_URI}GDM-The_Two_Towers.tar.gz
	${THEME_URI}GDM-STGO.tar.gz
	${THEME_URI}GDM-SUSE.tar.gz
	${THEME_URI}GDM-Thrall-1.0.tar.gz
	${THEME_URI}GDM-Todmorden.tar.gz
	${THEME_URI}GDM-Undead-1.0.tar.gz
	${THEME_URI}GDM-Unxstar.tar.gz
	${THEME_URI}GDM-Valladolid.tar.gz
	${THEME_URI}GDM-xpto.tar.gz
	${THEME_URI}GDM-gcr-ddlm.tar.gz
	${THEME_URI}GDM-gentoo-cow.tar.bz2
	${THEME_URI}GDM-labisbal.tar.gz
	${THEME_URI}GDM-penguin.tar.gz
	${THEME_URI}GDM-pixelgdm.tar.gz
	mirror://gentoo/GDM-gentoo-emergance_2.tar.gz"

HOMEPAGE="http://art.gnome.org/themes/gdm_greeter/"

RDEPEND="gnome-base/gdm"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~amd64 ~alpha ~ia64 ~ppc"
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
