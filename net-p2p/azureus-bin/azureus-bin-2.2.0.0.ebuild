# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/azureus-bin/azureus-bin-2.2.0.0.ebuild,v 1.2 2004/11/06 17:23:53 squinky86 Exp $

inherit eutils

DESCRIPTION="Azureus - Java BitTorrent Client"
HOMEPAGE="http://azureus.sourceforge.net/"

MY_PN=${PN/-bin/}
MY_PV="${PV}"
MY_DT=20040224

S=${WORKDIR}/${MY_PN}
SRC_URI="mirror://gentoo/seda-${MY_DT}.zip
	x86? ( mirror://sourceforge/${MY_PN}/Azureus_${MY_PV}_linux.GTK.tar.bz2 )
	amd64? ( mirror://sourceforge/${MY_PN}/Azureus_${MY_PV}_linux.AMD64.tar.bz2 )"

LICENSE="GPL-2 BSD"
SLOT="0"

# Still in progress... trying to get most external classes in through DEPENDs rather than 
KEYWORDS="~x86 ~amd64"
IUSE="kde"

DEPEND="virtual/libc
	amd64? ( app-arch/unzip )"

RDEPEND="${DEPEND}
	dev-java/commons-cli
	dev-java/log4j
	kde? ( dev-java/systray4j )
	dev-java/junit
	=x11-libs/gtk+-2*
	>=virtual/jre-1.4
	>=net-libs/linc-1.0.3"

# Where to install the package
PROGRAM_DIR="/usr/lib/${MY_PN}"

src_unpack() {
	if ! use kde; then
		einfo "The kde use flag is off, so the systray support will be disabled."
		einfo "kde is required to build dev-java/systray4j."
	fi

	if use amd64 ; then
		unpack Azureus_${MY_PV}_linux.AMD64.tar.bz2
	else
		unpack Azureus_${MY_PV}_linux.GTK.tar.bz2
	fi

	if use amd64 ; then
		cd ${S}
		unpack swt-3.0-linux-gtk-amd64.zip
		cd ${WORKDIR}
	fi

	cp ${FILESDIR}/${PN}-2.0.8.0a-gentoo.sh ${MY_PN}/azureus

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
	einfo "As of this version, the new ui type 'console' is supported,"
	einfo "and this may be set in ~/.Azureus/gentoo.config."
	echo
	ewarn "If you are upgrading, and the menu in azurues has entries like"
	ewarn "\"!MainWindow.menu.transfers!\" then you have a stray MessageBundle.properties file,"
	ewarn "and you may safely delete ~/.Azureus/MessagesBundle.properties"
	echo
}
