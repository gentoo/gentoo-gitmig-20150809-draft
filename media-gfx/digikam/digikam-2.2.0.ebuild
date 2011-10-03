# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-2.2.0.ebuild,v 1.1 2011/10/03 20:38:33 dilfridge Exp $

EAPI=4

KDE_LINGUAS="af ar az be bg bn br bs ca cs csb cy da de el en_GB eo es et eu fa fi fo
fr fy ga gl ha he hi hr hsb hu id is it ja ka kk km ko ku lb lo lt lv mi mk mn ms mt
nb nds ne nl nn nso oc pa pl pt pt_BR ro ru rw se sk sl sq sr sr@Latn ss sv ta te tg
th tr tt uk uz uz@cyrillic ven vi wa xh zh_CN zh_HK zh_TW zu"

KDE_HANDBOOK="optional"
CMAKE_MIN_VERSION="2.8"
KDE_MINIMAL="4.7"

inherit kde4-base

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Digital photo management application for KDE"
HOMEPAGE="http://www.digikam.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="addressbook debug doc gphoto2 mysql semantic-desktop themedesigner +thumbnails video"

CDEPEND="
	!!=media-gfx/digikam-2.1.0-r1
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
	$(add_kdebase_dep libkipi)
	$(add_kdebase_dep marble plasma)
	$(add_kdebase_dep solid)
	media-libs/jasper
	media-libs/lcms:0
	>=media-libs/lensfun-0.2.5
	>=media-libs/libkface-${PV}
	>=media-libs/libkgeomap-${PV}
	media-libs/liblqr
	>=media-libs/libpgf-6.11.28
	media-libs/libpng
	media-libs/tiff
	virtual/jpeg
	x11-libs/qt-gui[qt3support]
	|| ( >=sci-libs/clapack-3.2.1-r6 sci-libs/lapack-atlas )
	|| ( x11-libs/qt-sql[mysql] x11-libs/qt-sql[sqlite] )
	addressbook? ( $(add_kdebase_dep kdepimlibs) )
	gphoto2? ( media-libs/libgphoto2 )
	mysql? ( virtual/mysql )
"
RDEPEND="${CDEPEND}
	$(add_kdebase_dep kreadconfig)
	media-plugins/kipi-plugins
	video? (
		|| (
			$(add_kdebase_dep mplayerthumbs)
			$(add_kdebase_dep ffmpegthumbs)
		)
	)
"
DEPEND="${CDEPEND}
	sys-devel/gettext
	doc? ( app-doc/doxygen )
"

S="${WORKDIR}/${MY_P}/core"

RESTRICT=test
# bug 366505

src_prepare() {
	# just to make absolutely sure
	rm -rf "${WORKDIR}/${MY_P}/extra" || die

	# prepare the handbook
	mv "${WORKDIR}/${MY_P}/doc/${PN}" doc || die
	echo "add_subdirectory( digikam )" > doc/CMakeLists.txt
	echo "add_subdirectory( showfoto )" >> doc/CMakeLists.txt

	# prepare the translations
	mv "${WORKDIR}/${MY_P}/po" po || die
	find po -name "*.po" -and -not -name "digikam.po" -exec rm {} +

	echo "find_package(Msgfmt REQUIRED)" >> CMakeLists.txt || die
	echo "find_package(Gettext REQUIRED)" >> CMakeLists.txt || die
	echo "add_subdirectory( po )" >> CMakeLists.txt || die

	kde4-base_src_prepare

	if use handbook; then
		echo "add_subdirectory( doc )" >> CMakeLists.txt
	fi
}

src_configure() {
	local backend

	use semantic-desktop && backend="Nepomuk" || backend="None"
	# LQR = only allows to choose between bundled/external
	local mycmakeargs=(
		-DFORCED_UNBUNDLE=ON
		-DWITH_LQR=ON
		-DWITH_LENSFUN=ON
		-DGWENVIEW_SEMANTICINFO_BACKEND=${backend}
		$(cmake-utils_use_with addressbook KdepimLibs)
		-DWITH_MarbleWidget=ON
		$(cmake-utils_use_enable gphoto2 GPHOTO2)
		$(cmake-utils_use_with gphoto2)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_enable themedesigner)
		$(cmake-utils_use_enable thumbnails THUMBS_DB)
		$(cmake-utils_use_enable mysql INTERNALMYSQL)
		$(cmake-utils_use_enable debug DEBUG_MESSAGES)
	)

	kde4-base_src_configure
}

src_compile() {
	local mytargets="all"
	use doc && mytargets+=" doc"

	kde4-base_src_compile ${mytargets}
}

src_install() {
	kde4-base_src_install

	if use doc; then
		# install the api documentation
		insinto /usr/share/doc/${PF}/html
		doins -r ${CMAKE_BUILD_DIR}/api/html/*
	fi
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use doc; then
		elog "The digikam api documentation has been installed at /usr/share/doc/${PF}/html"
	fi
}
