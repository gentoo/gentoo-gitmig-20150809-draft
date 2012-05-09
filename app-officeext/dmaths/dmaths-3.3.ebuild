# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/dmaths/dmaths-3.3.ebuild,v 1.1 2012/05/09 20:33:54 scarabeus Exp $

EAPI=4

OO_EXTENSIONS=(
	"DmathsAddon.oxt"
)
inherit office-ext

DESCRIPTION="Formula Editor Extension"
HOMEPAGE="http://www.dmaths.org/"
SRC_URI="http://www.${PN}.org/documentation/lib/exe/fetch.php?media=description:${PN}${PV/./}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/ooo"
DEPEND="${RDEPEND}"

S="${WORKDIR}/Dmaths${PV/./}"
