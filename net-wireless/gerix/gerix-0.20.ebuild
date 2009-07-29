# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gerix/gerix-0.20.ebuild,v 1.3 2009/07/29 15:04:18 scarabeus Exp $

EAPI="2"

MY_P="${PN}-wifi-cracker-ng-${PV/0./r}"
inherit base

DESCRIPTION="Qt3 Based aircrack GUI"
HOMEPAGE="http://backtrack.it/~emgent/hackstuff/Gerix-Wifi-Cracker-NG/index-en.html"
SRC_URI="http://backtrack.it/~emgent/hackstuff/Gerix-Wifi-Cracker-NG/download/${MY_P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/PyQt"
RDEPEND="${DEPEND}
	gnome-extra/zenity
	net-analyzer/macchanger
	net-wireless/aircrack-ng
	x11-terms/xterm
"

S="${WORKDIR}/${MY_P}"

src_install() {
	make_wrapper ${PN} /usr/share/${PN}/${PN}.py "" "" /usr/sbin
	insinto /usr/share/${PN}
	doins ${PN}*.{py,ui{,.h},png} || die
	fperms 755 /usr/share/${PN}/${PN}.py || die

}
