# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/compizconfig-backend-kconfig/compizconfig-backend-kconfig-0.8.4-r1.ebuild,v 1.1 2009/10/23 17:27:49 ssuominen Exp $

EAPI=2
KDE_MINIMAL=4.2
MY_P=${PN}4-${PV}

inherit kde4-base

DESCRIPTION="Compizconfig Kconfig Backend"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-dbus:4
	~x11-libs/libcompizconfig-${PV}
	~x11-wm/compiz-${PV}"

S=${WORKDIR}/${MY_P}
