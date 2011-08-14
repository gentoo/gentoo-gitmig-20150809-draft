# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-2.0.0.ebuild,v 1.3 2011/08/14 18:14:02 dilfridge Exp $

EAPI=4

OPENGL_REQUIRED="optional"

KDE_MINIMAL="4.7"

KDE_LINGUAS="ar az be bg bn br bs ca cs csb cy da de el en_GB eo es et eu fa fi fo fr fy ga
gl ha he hi hr hsb hu id is it ja ka kk km ko ku lb lo lt lv mi mk mn ms mt nb nds ne nl nn
nso oc pa pl pt pt_BR ro ru rw se sk sl sq sr ss sv ta te tg th tr tt uk uz ven vi wa xh
zh_CN zh_HK zh_TW zu"

inherit flag-o-matic kde4-base

MY_P="digikam-${PV/_/-}"

DESCRIPTION="Plugins for the KDE Image Plugin Interface"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"

LICENSE="GPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="cdr calendar crypt debug expoblending gpssync handbook +imagemagick ipod +mediawiki mjpeg redeyes scanner"

DEPEND="
	$(add_kdebase_dep libkipi)
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
	dev-libs/expat
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/qjson
	gpssync?	( >=media-libs/libkgeomap-${PV} )
	mediawiki?	( >=media-libs/libmediawiki-${PV} )
	media-libs/libpng
	media-libs/tiff
	virtual/jpeg
	calendar?	( $(add_kdebase_dep kdepimlibs) )
	crypt?		( app-crypt/qca:2 )
	ipod?		(
			  media-libs/libgpod
			  x11-libs/gtk+:2
			)
	redeyes?	( media-libs/opencv )
	scanner? 	(
			  $(add_kdebase_dep libksane)
			  media-gfx/sane-backends
			)
"
RDEPEND="${DEPEND}
	cdr? 		( app-cdr/k3b )
	expoblending? 	( media-gfx/hugin )
	imagemagick? 	( || ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] ) )
	mjpeg? 		( media-video/mjpegtools )
"

S=${WORKDIR}/${MY_P}/extra/${PN}

PATCHES=(
	"${FILESDIR}/${PN}-1.7.0-expoblending.patch"
	"${FILESDIR}/${PN}-2.0.0-tests.patch"
)

src_prepare() {
	# prepare the handbook
	mv "${WORKDIR}/${MY_P}/doc/${PN}" "${WORKDIR}/${MY_P}/extra/${PN}/doc" || die
	if use handbook; then
		echo "add_subdirectory( doc )" >> CMakeLists.txt
	fi

	# prepare the translations
	mv "${WORKDIR}/${MY_P}/po" po || die
	find po -name "digikam.po" -exec rm {} +
	echo "add_subdirectory( po )" >> CMakeLists.txt

	kde4-base_src_prepare
}

src_configure() {
	# Remove flags -floop-block -floop-interchange
	# -floop-strip-mine due to bug #305443.
	filter-flags -floop-block
	filter-flags -floop-interchange
	filter-flags -floop-strip-mine

	mycmakeargs+=(
		$(cmake-utils_use_with ipod GLIB2)
		$(cmake-utils_use_with ipod GObject)
		$(cmake-utils_use_with ipod Gdk)
		$(cmake-utils_use_with ipod Gpod)
		$(cmake-utils_use_with calendar KdepimLibs)
		$(cmake-utils_use_with mediawiki Mediawiki)
		$(cmake-utils_use_with gpssync KGeoMap)
		$(cmake-utils_use_with redeyes OpenCV)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with scanner Sane)
		$(cmake-utils_use_enable expoblending)
	)

	kde4-base_src_configure
}
