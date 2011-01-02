# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbluedevil/libbluedevil-1.8.ebuild,v 1.1 2011/01/02 17:28:38 dilfridge Exp $

EAPI="3"

inherit kde4-base

MY_P=${PN}-v${PV}-1
DESCRIPTION="Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://gitorious.org/libbluedevil"
SRC_URI="http://media.ereslibre.es/2010/11/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	net-wireless/bluez
"

S=${WORKDIR}/${MY_P}
