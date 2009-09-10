# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-2.0_pre2.ebuild,v 1.1 2009/09/10 13:43:22 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A collection manager for the KDE environment."
HOMEPAGE="http://www.periapsis.org/tellico/"
SRC_URI="http://tellico-project.org/files/${P/_}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=kde-base/libkcddb-4.2
	>=kde-base/libksane-4.2
	>=kde-base/kdepimlibs-4.2
	>=media-libs/exempi-2
	dev-libs/libxslt
	dev-libs/libxml2
	>=media-libs/taglib-1.5
	>=dev-libs/yaz-2
	virtual/poppler-qt4
	x11-libs/qt-dbus:4
	kde-base/qimageblitz"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/_}
