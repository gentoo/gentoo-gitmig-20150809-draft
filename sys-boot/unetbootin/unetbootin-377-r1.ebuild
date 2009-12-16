# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/unetbootin/unetbootin-377-r1.ebuild,v 1.2 2009/12/16 21:34:36 maekke Exp $

inherit qt4

DESCRIPTION="Universal Netboot Installer creates Live USB systems for various OS
distributions."
HOMEPAGE="http://unetbootin.sourceforge.net/"
SRC_URI="mirror://sourceforge/unetbootin/${PN}-source-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}"

DEPEND="x11-libs/qt-gui"
RDEPEND="${DEPEND}
		 sys-fs/mtools
		 sys-boot/syslinux
		 app-arch/p7zip"

src_compile() {
	lupdate unetbootin.pro
	lrelease unetbootin.pro
	eqmake4 unetbootin.pro
	emake || die "make failed"
}

src_install() {
	dodoc README.TXT
	dobin unetbootin || die "dobin failed"
	insinto /usr/share/applications
	doins unetbootin.desktop
}
