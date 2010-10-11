# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/unetbootin/unetbootin-494.ebuild,v 1.1 2010/10/11 18:52:15 jer Exp $

EAPI="3"

inherit qt4-r2

DESCRIPTION="Universal Netboot Installer creates Live USB systems for various OS
distributions."
HOMEPAGE="http://unetbootin.sourceforge.net/"
SRC_URI="mirror://sourceforge/unetbootin/${PN}-source-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

DEPEND="x11-libs/qt-gui"
RDEPEND="${DEPEND}
		 sys-fs/mtools
		 sys-boot/syslinux
		 app-arch/p7zip"

src_configure() {
	lupdate unetbootin.pro || die "lupdate failed"
	lrelease unetbootin.pro || die "lrelease failed"
	eqmake4 unetbootin.pro || die "eqmake4 failed"
}

src_install() {
	dobin unetbootin || die "dobin failed"
	insinto /usr/share/applications
	doins unetbootin.desktop || die "doins failed"
}
