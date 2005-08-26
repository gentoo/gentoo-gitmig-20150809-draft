# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/licq-themes/licq-themes-0.0.1.ebuild,v 1.13 2005/08/26 13:57:57 agriffis Exp $

DESCRIPTION="Collection of licq themes"
HOMEPAGE="http://www.licq.org"
SKIN_URI="http://www.crewqstudios.com/licq/download/skins"
ICON_URI="http://www.crewqstudios.com/licq/download/icons"
SRC_URI="
	${SKIN_URI}/skin.adept.tar.gz
	${SKIN_URI}/skin.alien.tar.gz
	${SKIN_URI}/skin.blackbox.tar.gz
	${SKIN_URI}/skin.bluex.tar.gz
	${SKIN_URI}/skin.border.tar.gz
	${SKIN_URI}/skin.brgnd-e.tar.gz
	${SKIN_URI}/skin.circuit.tar.gz
	${SKIN_URI}/skin.cra.tar.gz
	${SKIN_URI}/skin.crack.tar.gz
	${SKIN_URI}/skin.delta.tar.gz
	${SKIN_URI}/skin.discrete.tar.gz
	${SKIN_URI}/skin.expo2000.tar.gz
	${SKIN_URI}/skin.futurama.tar.gz
	${SKIN_URI}/skin.get-e-blue.licq.tar.gz
	${SKIN_URI}/skin.greyhound.tar.gz
	${SKIN_URI}/skin.hopkoplin.tar.gz
	${SKIN_URI}/skin.icq2000.tar.gz
	${SKIN_URI}/skin.jammet.tar.bz2
	${SKIN_URI}/skin.karin.tar.gz
	${SKIN_URI}/skin.kiwix.tar.gz
	${SKIN_URI}/skin.ladydeath.tar.gz
	${SKIN_URI}/skin.lava.tar.gz
	${SKIN_URI}/skin.luna.tar.gz
	${SKIN_URI}/skin.madmax.tar.gz
	${SKIN_URI}/skin.marble.tar.gz
	${SKIN_URI}/skin.neon.tar.gz
	${SKIN_URI}/skin.penguin.tar.gz
	${SKIN_URI}/skin.phone.tar.gz
	${SKIN_URI}/skin.shagadelic.tar.gz
	${SKIN_URI}/skin.scalpel.tar.gz
	${SKIN_URI}/skin.sick-colours.tar.gz
	${SKIN_URI}/skin.simple.tar.gz
	${SKIN_URI}/skin.skulls.tar.gz
	${SKIN_URI}/skin.skydreamer-2.tar.gz
	${SKIN_URI}/skin.supernova.tar.gz

	${ICON_URI}/icons.circuit.tar.gz
	${ICON_URI}/icons.crysball.tar.gz
	${ICON_URI}/icons.dots2.tar.gz
	${ICON_URI}/icons.emac_1.tar.gz
	${ICON_URI}/icons.evangelion.tar.gz
	${ICON_URI}/icons.futurama.tar.gz
	${ICON_URI}/icons.galadriels_mirror.tar.gz
	${ICON_URI}/icons-goldfish.tar.gz
	${ICON_URI}/icons.ickle.tar.gz
	${ICON_URI}/icons.kicq.tar.gz
	${ICON_URI}/icons-kicq-trans.tar.gz
	${ICON_URI}/icons.lorg.tar.bz2
	${ICON_URI}/icons.mark-blue-1.1.tar.gz
	${ICON_URI}/icon.ms-icq.tar.gz
	${ICON_URI}/icons.simpsons.tar.gz
	${ICON_URI}/icons.smiley-trans.1-0a.tar.gz
	${ICON_URI}/icons.sp.tar.gz
	${ICON_URI}/icons.symbols.tar.gz
	${ICON_URI}/icons.triangles.tar.gz
"


SLOT="0"
LICENSE="freedist"
KEYWORDS="alpha ~amd64 ~ia64 ppc sparc x86"
IUSE=""

RDEPEND="net-im/licq"

src_unpack() {
	local bn
	mkdir ${S}
	cd ${S}
	for i in ${SRC_URI} ; do
		bn=`basename $i`
		if [ -n "`echo ${bn} | grep '\.zip'`" ] ; then
			cp ${DISTDIR}/${bn} .
		else
			unpack ${bn}
		fi
	done
}

src_compile() {
	# Rename Theme-File from Evangelion-Theme to the name licq seeks for
	mv ${S}/icons.evangelion/eva.icons ${S}/icons.evangelion/evangelion.icons

	# Correct Permissions of Theme-Directories and Files
	chmod 755 ${S}/*
	chmod 644 ${S}/*/*
	# Delete backup-files
	rm ${S}/*/*~
	einfo "No compilation necessary."
}

src_install () {
	dodir /usr/share/licq/qt-gui/
	cp -dpR * ${D}/usr/share/licq/qt-gui/
}
