# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-2.1.1.ebuild,v 1.1 2009/11/21 10:55:48 scarabeus Exp $

EAPI=2
KDE_LINGUAS="bg ca cs da de el en_GB es et fi fr ga gl hu it lt ms nb nds nl nn
pl pt pt_BR ro ru sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit kde4-base

DESCRIPTION="A collection manager for the KDE environment"
HOMEPAGE="http://tellico-project.org/"
SRC_URI="http://tellico-project.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="addressbook cddb debug +handbook pdf scanner taglib v4l xmp yaz"

DEPEND="dev-libs/libxml2
	dev-libs/libxslt
	kde-base/qimageblitz
	x11-libs/qt-dbus:4
	addressbook? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	cddb? ( >=kde-base/libkcddb-${KDE_MINIMAL} )
	pdf? ( virtual/poppler-qt4 )
	scanner? ( >=kde-base/libksane-${KDE_MINIMAL} )
	taglib? ( >=media-libs/taglib-1.5 )
	xmp? ( >=media-libs/exempi-2 )
	yaz? ( >=dev-libs/yaz-2 )
	v4l? ( media-libs/libv4l )"

DOCS="AUTHORS ChangeLog"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Kcal=OFF
		$(cmake-utils_use_with addressbook Kabc)
		$(cmake-utils_use_with addressbook Kcal)
		$(cmake-utils_use_with cddb Kcddb)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with taglib)
		$(cmake-utils_use_with xmp Exempi)
		$(cmake-utils_use_with yaz)
		$(cmake-utils_use_with v4l)"

	kde4-base_src_configure
}
