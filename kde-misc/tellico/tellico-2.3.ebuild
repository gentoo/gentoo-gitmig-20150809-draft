# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-2.3.ebuild,v 1.3 2011/01/13 01:48:11 tampakrap Exp $

EAPI=3

KDE_LINGUAS="ca ca@valencia cs da de el en_GB es et fi fr gl hu it nb nds nl nn
pl pt pt_BR ru sv tr uk zh_CN"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit kde4-base

DESCRIPTION="A collection manager for the KDE environment"
HOMEPAGE="http://tellico-project.org/"
SRC_URI="http://tellico-project.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="addressbook cddb debug +handbook pdf scanner taglib v4l xmp yaz"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	media-libs/qimageblitz
	x11-libs/qt-dbus:4
	addressbook? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	cddb? ( >=kde-base/libkcddb-${KDE_MINIMAL} )
	pdf? ( >=app-text/poppler-0.12.3-r3[qt4] )
	scanner? ( >=kde-base/libksane-${KDE_MINIMAL} )
	taglib? ( >=media-libs/taglib-1.5 )
	v4l? ( media-libs/libv4l )
	xmp? ( >=media-libs/exempi-2 )
	yaz? ( >=dev-libs/yaz-2 )
"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog README"

RESTRICT=test

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable v4l WEBCAM)
		$(cmake-utils_use_with xmp Exempi)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with cddb Kcddb)
		$(cmake-utils_use_with addressbook KdepimLibs)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with taglib)
		$(cmake-utils_use_with yaz)
	)

	kde4-base_src_configure
}
