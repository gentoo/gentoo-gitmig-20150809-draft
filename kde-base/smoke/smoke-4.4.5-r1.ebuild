# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smoke/smoke-4.4.5-r1.ebuild,v 1.2 2011/03/26 17:14:15 dilfridge Exp $

EAPI="3"

KMNAME="kdebindings"
MULTIMEDIA_REQUIRED="optional"
WEBKIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Scripting Meta Object Kompiler Engine"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="akonadi attica debug okular +phonon qimageblitz qscintilla qwt semantic-desktop"

COMMON_DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	akonadi? ( $(add_kdebase_dep kdepimlibs) )
	attica? ( dev-libs/libattica )
	okular? ( $(add_kdebase_dep okular) )
	phonon? ( >=media-libs/phonon-4.3.80 )
	qimageblitz? ( >=media-libs/qimageblitz-0.0.4 )
	qscintilla? ( x11-libs/qscintilla )
	qwt? ( x11-libs/qwt:5 )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

PATCHES=( "${FILESDIR}/${P}-typecompiler.patch" )

KMEXTRA="generator/"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_enable attica ATTICA_SMOKE)
		$(cmake-utils_use_enable multimedia QTMULTIMEDIA_SMOKE)
		$(cmake-utils_use_with okular)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_enable phonon PHONON_SMOKE)
		$(cmake-utils_use_enable qimageblitz QIMAGEBLITZ_SMOKE)
		$(cmake-utils_use_with qscintilla QScintilla)
		$(cmake-utils_use_enable qwt QWT_SMOKE)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_enable webkit QTWEBKIT_SMOKE)
	)
	kde4-meta_src_configure
}
