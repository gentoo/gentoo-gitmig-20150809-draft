# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/air/air-1.2.5.ebuild,v 1.1 2004/09/12 10:27:21 dragonheart Exp $

inherit eutils

DESCRIPTION="A GUI front-end to dd/dcfldd"
HOMEPAGE="http://air-imager.sourceforge.net/"
SRC_URI="mirror://sourceforge/air-imager/${P}.tar.gz"

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
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-installfix.patch

	#sandbox installer
	sed -i -e "s!^INSTALL_DIR=.*!INSTALL_DIR=\"${D}/usr\"!" \
		install-${P}
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	dodir "/usr/bin"
	./install-${P}
	dodoc README

	cd ${D}/usr/bin
	#/usr/bin/air has hardcoded paths we need to fix
	sed -i -e "s!/usr/local!/usr!g" air

	mkfifo ${D}/usr/share/air/air-fifo
	chown -R root:root ${D}
	fowners root:users /usr/share/air/logs /usr/share/air/air-fifo
	fperms ug+rwx /usr/share/air/logs /usr/share/air/air-fifo
}

pkg_postinst() {
	einfo "This will use programs from the following packages if installed:"
	einfo "sys-apps/dcfldd"
	einfo "net-analyzer/netcat"
	einfo "net-analyzer/cryptcat"
}
