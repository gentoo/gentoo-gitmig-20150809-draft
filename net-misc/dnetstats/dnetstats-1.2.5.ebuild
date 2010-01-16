# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dnetstats/dnetstats-1.2.5.ebuild,v 1.1 2010/01/16 12:25:45 hwoarang Exp $

EAPI="2"

inherit qt4-r2

MY_PN="DNetStats"
MY_P="${MY_PN}-v${PV}-release"

DESCRIPTION="Qt4 network monitor utility"
HOMEPAGE="http://qt-apps.org/content/show.php/DNetStats?content=107467"
SRC_URI="http://qt-apps.org/CONTENT/content-files/107467-${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	kde? ( kde-base/kdesu )"

src_prepare() {
	# remove old moc_* files
	rm -rf moc_* || die "failed to remove old moc_* files"
}

src_install() {
	newbin mythread ${PN} || die "newbin failed"
	dodoc ReadMe || die "dodoc failed"
	newicon resource/energy.png ${PN}.png || die "doicon failed"
	make_desktop_entry ${PN} DNetStats ${PN}.png 'Qt;Network;Dialup'
	# adjust the .desktop file
	if use kde; then
		sed -i "/^Exec/s:${PN}:kdesu -c ${PN}:" \
			${D}/usr/share/applications/"${PN}"-"${PN}".desktop \
			|| die "failed to add kdesu on desktop file"
	fi
}

pkg_postinst() {
	if ! use kde; then
		elog
		elog "Root priviledges are required in order to run ${PN}"
		elog
	fi
}
