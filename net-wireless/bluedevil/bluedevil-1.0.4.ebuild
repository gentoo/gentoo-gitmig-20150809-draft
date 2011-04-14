# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluedevil/bluedevil-1.0.4.ebuild,v 1.1 2011/04/14 17:55:47 scarabeus Exp $

EAPI=4

KDE_LINGUAS="ca ca@valencia cs da de en_GB eo es et eu fr ga hu it ja ko lt mai ms nb nds nl pa
pl pt pt_BR ro ru sk sl sv th tr uk zh_TW"
inherit kde4-base

DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://projects.kde.org/projects/extragear/base/bluedevil"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/libbluedevil-1.8.1
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	!net-wireless/kbluetooth
	app-mobilephone/obexd[-server]
	app-mobilephone/obex-data-server
"
