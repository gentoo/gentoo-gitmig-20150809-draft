# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/qmultirecord/qmultirecord-0.0.3.ebuild,v 1.1 2009/08/12 19:07:49 ssuominen Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="CD and DVD recording frontend for cdrtools and dvd+rw-tools"
HOMEPAGE="http://qt-apps.org/content/show.php/qmultirecord?content=106254"
SRC_URI="http://qt-apps.org/CONTENT/content-files/106254-${P}_fix.tar.bz2 ->
${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEPEND="x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-core:4"
RDEPEND="${COMMON_DEPEND}
	sys-apps/eject
	app-cdr/dvd+rw-tools
	virtual/cdrtools"
DEPEND="${COMMON_DEPEND}"

PATCHES=( "${FILESDIR}/${P}-langinfo_h.patch" )

src_configure() {
	eqmake4 ${PN}.pro
}

src_install() {
	exeinto /usr/libexec
	doexe bin/*.bin || die "doexe failed"
	insinto /usr/share/${PN}
	doins bin/*.txt || die "doins failed"
	dobin "${FILESDIR}"/${PN} || die "dobin failed"
	newicon src/icons/burn_on.png ${PN}.png
	make_desktop_entry ${PN} QMultirecorder ${PN} "Utility;Qt;DiscBurning"
	dodoc ChangeLog README TODO bin/*.example || die "dodoc failed"
}
