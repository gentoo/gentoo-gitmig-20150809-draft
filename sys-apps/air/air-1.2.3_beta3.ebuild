# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/air/air-1.2.3_beta3.ebuild,v 1.7 2004/07/18 06:04:19 dragonheart Exp $

inherit eutils

DESCRIPTION="A GUI front-end to dd/dcfldd"
HOMEPAGE="http://air-imager.sourceforge.net/"
MY_P=${P/_/-}
SRC_URI="mirror://sourceforge/air-imager/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-perl/perl-tk
	app-arch/sharutils
	>=sys-apps/sed-4"
RDEPEND="app-arch/mt-st
	dev-lang/perl"

src_unpack() {
	#The tarball doesn't have a directory
	mkdir ${S}
	cd ${S}
	unpack ${A}
	epatch ${FILESDIR}/${P}-installfix.patch

	#sandbox installer
	sed -i -e "s!INSTALL_DIR=\"/usr\"!INSTALL_DIR=\"${D}/usr\"!" \
		-e "s!TEMP_DIR=\"/tmp\"!TEMP_DIR=\"${T}\"!" \
		install-${MY_P}
}

src_install() {
	dodir "/usr/bin"
	cd ${S}
	/bin/sh install-${MY_P}
	dodoc README

	cd ${D}/usr/bin
	#/usr/bin/air has hardcoded paths we need to fix
	sed -i -e "s!bitmap_dir=\"/usr/local!bitmap_dir=\"/usr!" \
		-e "s!air_log_dir = \"/usr/local!air_log_dir = \"/usr!" \
		-e "s!air_fifo = \"/usr/local!air_fifo = \"/usr!" \
	  	-e "s!-col !-column !" \
		-e "s!-col=!-column=!" \
		air

	mkfifo ${D}/usr/share/air/air-fifo
	chown -R root:root ${D}
	fowners root:users /usr/share/air/logs/
	fperms ug+rwx /usr/share/air/logs/ /usr/share/air/air-fifo
}
