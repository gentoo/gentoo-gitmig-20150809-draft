# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluedevil/bluedevil-1.1-r2.ebuild,v 1.1 2011/05/30 09:58:07 scarabeus Exp $

EAPI=4

KDE_LINGUAS="ca ca@valencia cs da de el en_GB eo es et eu fi fr hu it ja ko lt
mai ms nb nds nl pa pl pt pt_BR ro ru sk sl sv th tr uk zh_TW"
inherit kde4-base

DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://projects.kde.org/projects/extragear/base/bluedevil"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/libbluedevil-1.9
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	!net-wireless/kbluetooth
	app-mobilephone/obexd[-server]
	app-mobilephone/obex-data-server
"

PATCHES=(
	"${FILESDIR}/${PN}-mimetypes.patch"
)
