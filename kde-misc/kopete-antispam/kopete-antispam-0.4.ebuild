# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kopete-antispam/kopete-antispam-0.4.ebuild,v 1.2 2009/02/03 10:18:42 alexxy Exp $

EAPI="2"
KDE_MINIMAL="4.1"

inherit kde4-base

MY_PN=${PN/-/}
MY_P="${PN}-kde4-${PV}"

DESCRIPTION="Antispam filter for Kopete instant messenger."
HOMEPAGE="http://kopeteantispam.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/kopete-${KDE_MINIMAL}"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${P}-fixlink.patch" )

pkg_postinst() {
	elog "You can now enable and set up the Antispam plugin in Kopete."
	elog "It can be reached in the Kopete Plugin dialog."
}
