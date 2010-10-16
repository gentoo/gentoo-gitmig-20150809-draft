# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-1.5.0.ebuild,v 1.2 2010/10/16 17:59:18 dilfridge Exp $

EAPI="2"

OPENGL_REQUIRED="optional"
KDE_LINGUAS="ar be ca ca@valencia cs de el en_GB eo es eu fi gl hi hne hr is ja km
lt lv mai ms nds nl pt pt_BR ro ru se sk sv th uk zh_CN zh_TW"
KMNAME="extragear/graphics"
KDE_MINIMAL="4.5"
inherit flag-o-matic kde4-base

DESCRIPTION="Plugins for the KDE Image Plugin Interface"
HOMEPAGE="http://www.kipi-plugins.org"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2
	handbook? ( mirror://gentoo/${PN}-doc-${PV}.tar.bz2 )"

LICENSE="GPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="cdr calendar crypt debug expoblending handbook +imagemagick ipod mjpeg redeyes scanner"

DEPEND="
	>=dev-libs/expat-2.0.1
	>=dev-libs/libxml2-2.7
	>=dev-libs/libxslt-1.1
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2
	>=media-libs/tiff-3.6
	calendar? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	crypt? ( app-crypt/qca:2 )
	ipod? (
		>=media-libs/libgpod-0.7
		x11-libs/gtk+:2
	)
	redeyes? ( media-libs/opencv )
	scanner? (
		>=kde-base/libksane-${KDE_MINIMAL}
		media-gfx/sane-backends
	)
"
RDEPEND="${DEPEND}
	cdr? ( app-cdr/k3b )
	expoblending? ( media-gfx/hugin )
	imagemagick? ( media-gfx/imagemagick )
	mjpeg? ( media-video/mjpegtools )
"

PATCHES=( "${FILESDIR}/${PN}-1.3.0-expoblending.patch" )

src_prepare() {
	if use handbook; then
		echo "add_subdirectory( doc )" >> CMakeLists.txt
	else
		mkdir doc || die
		echo >> doc/CMakeLists.txt || die
	fi

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
		$(cmake-utils_use_with redeyes OpenCV)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with scanner Sane)
		$(cmake-utils_use_enable expoblending)
	)

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	if use handbook; then
		dodoc readme-handbook.txt || die
	fi
}
