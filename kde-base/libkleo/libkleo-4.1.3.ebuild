# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkleo/libkleo-4.1.3.ebuild,v 1.1 2008/11/09 01:22:47 scarabeus Exp $

EAPI="2"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KDE library for encryption handling."
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="app-crypt/gnupg
	>=kde-base/kdepimlibs-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

src_configure() {
	mycmakeargs="${mycmakeargs} -DWITH_QGPGME=ON"

	kde4-meta_src_configure
}
