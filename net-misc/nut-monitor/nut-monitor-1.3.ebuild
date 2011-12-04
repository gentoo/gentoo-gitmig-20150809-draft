# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nut-monitor/nut-monitor-1.3.ebuild,v 1.1 2011/12/04 14:09:57 jlec Exp $

EAPI=4

inherit eutils

DESCRIPTION="A graphical application to monitor and manage UPSes connected to a NUT server"
HOMEPAGE="http://www.lestat.st/informatique/projets/nut-monitor-en/"
SRC_URI="http://www.lestat.st/_media/informatique/projets/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/pygtk
	dev-python/pynut"
DEPEND=""

src_install() {
	dobin NUT-Monitor
	insinto /usr/share/nut-monitor
	doins gui-${PV}.glade
	dosym NUT-Monitor /usr/bin/${PN}
	doicon ${PN}.png
	domenu ${PN}.desktop
	dodoc README
}
