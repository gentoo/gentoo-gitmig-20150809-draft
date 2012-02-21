# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbluedevil/libbluedevil-1.9.1.ebuild,v 1.2 2012/02/21 18:01:22 ago Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://projects.kde.org/projects/playground/libs/libbluedevil"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	net-wireless/bluez
"
