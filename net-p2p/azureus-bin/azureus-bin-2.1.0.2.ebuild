# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/azureus-bin/azureus-bin-2.1.0.2.ebuild,v 1.4 2004/11/06 17:23:53 squinky86 Exp $

inherit eutils

DESCRIPTION="Azureus - Java BitTorrent Client"
HOMEPAGE="http://azureus.sourceforge.net/"

MY_PN=${PN/-bin/}
MY_PV="${PV}"
MY_DT=20040224

S=${WORKDIR}/${MY_PN}
SRC_URI="mirror://sourceforge/${MY_PN}/Azureus_${MY_PV}_linux.GTK.tar.bz2
	 mirror://sourceforge/${MY_PN}/Azureus_${MY_PV}_linux.Motif.tar.bz2
	 mirror://gentoo/seda-${MY_DT}.zip"

RESTRICT="nomirror"

LICENSE="GPL-2 BSD"
SLOT="0"

# Still in progress... trying to get most external classes in through DEPENDs rather than 
KEYWORDS="~x86"
IUSE="gtk kde"

DEPEND="virtual/libc"

RDEPEND="${DEPEND}
	dev-java/commons-cli
	dev-java/log4j
	kde? ( dev-java/systray4j )
	dev-java/junit
	gtk? ( =x11-libs/gtk+-2* )
	!gtk? ( =x11-libs/openmotif-2.1* )
	>=virtual/jre-1.4
	>=net-libs/linc-1.0.3"

# Where to install the package
PROGRAM_DIR="/usr/lib/${MY_PN}"

src_unpack() {
	if ! use kde; then
		einfo "The kde use flag is off, so the systray support will be disabled."
		einfo "kde is required to build dev-java/systray4j."
	fi

	if use gtk; then
		unpack Azureus_${MY_PV}_linux.GTK.tar.bz2
		echo
		einfo "Using the GTK Azureus package, to use the Motif package"
		einfo "  set USE=\"-gtk\" in /etc/make.conf."
		echo
	else
		unpack Azureus_${MY_PV}_linux.Motif.tar.bz2
		echo
		einfo "Using the Motif Azureus package, to use the GTK package"
		einfo "  set USE=\"gtk\" in /etc/make.conf."
		echo

		# These are provided by =x11-libs/openmotif-2.1.*
		rm ${S}/libXm.so ${S}/libXm.so.2 ${S}/libXm.so.2.1
	fi

	cp ${FILESDIR}/${PN}-2.0.8.0a-gentoo.sh ${S}/azureus

	# Set runtime settings in the startup script
	sed -i "s:##PROGRAM_DIR##:${PROGRAM_DIR}:" ${MY_PN}/azureus

	# Unpack seda
	cd ${S}
	unpack seda-${MY_DT}.zip
	tar xjf seda-jnilibs-linux.tar.bz2
	rm seda*bz2
}

src_compile() {
	einfo "Binary only installation.  No compilation required."
}

src_install() {
	cd ${S}

	insinto ${PROGRAM_DIR}
	exeinto ${PROGRAM_DIR}

	doins *.jar
	doexe *.so

	# keep the plugins dir bug reports from flowing in
	insinto ${PROGRAM_DIR}/plugins/azupdater
	doins plugins/azupdater/*

	dobin azureus

	insinto /usr/share/pixmaps
	doins ${FILESDIR}/azureus.png

	insinto /usr/share/applications
	doins ${FILESDIR}/azureus.desktop

	dodoc README.linux seda-README.txt
	dohtml swt-about.html
}

pkg_postinst() {
	echo
	einfo "Due to the nature of the portage system, we recommend"
	einfo "that users check portage for new versions of Azureus"
	einfo "instead of attempting to use the auto-update feature."
	einfo "You can disable the upgrade warning in"
	einfo "View->Configuration->Interface->Start"
	echo
	einfo "After running azureus for the first time, configuration"
	einfo "options will be placed in ~/.Azureus/gentoo.config"
	einfo "It is recommended that you modify this file rather than"
	einfo "the azureus startup script directly."
	echo
	einfo "Currently, only the swt interface is available (ie, the setting"
	einfo "in ~/.Azureus/gentoo.config is ignored).  If you want to use"
	einfo "any of the other interfaces, you will need to get a CVS version"
	einfo "of the Azureus2.jar from http://azureus.sourceforge.net/index_CVS.php"
	einfo "and replace ${PROGRAM_DIR}/Azureus2.jar with it.  If you do this,"
	einfo "the setting in ~/.Azureus/gentoo.config will be properly used, but"
	einfo "you should report all bugs pertaining to the CVS release to the"
	einfo "azureus developers and not Gentoo."
	echo
}
