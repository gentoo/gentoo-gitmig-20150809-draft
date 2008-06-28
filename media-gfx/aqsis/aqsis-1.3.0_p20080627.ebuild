# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aqsis/aqsis-1.3.0_p20080627.ebuild,v 1.1 2008/06/28 06:17:50 maekke Exp $

EAPI="1"

inherit versionator multilib eutils

DESCRIPTION="Open source RenderMan-compliant 3D rendering solution"
HOMEPAGE="http://www.aqsis.org"
_PV=($(get_version_components ${PV}))
DATE="${_PV[3]/p/}"
DATE="${DATE:0:4}-${DATE:4:2}-${DATE:6:2}"
MY_P="${PN}-$(get_version_component_range 1-3)-${DATE}"
SRC_URI="http://download.aqsis.org/builds/testing/source/tar/${MY_P}.tar.gz"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+fltk openexr"

RDEPEND="
	>=media-libs/tiff-3.7.1
	>=sys-libs/zlib-1.1.4
	fltk? ( >=x11-libs/fltk-1.1.0 )
	openexr? ( media-libs/openexr )"

DEPEND="
	${RDEPEND}
	dev-libs/libxslt
	>=dev-libs/boost-1.34.0
	>=sys-devel/flex-2.5.4
	>=sys-devel/bison-1.35
	>=dev-util/cmake-2.4"

src_compile() {
	if use fltk ; then
		# hack to get fltk library/include paths
		# (upstream doesn't autodetect the gentoo install path for fltk)
		fltk_version="$(get_version_component_range 1-2 \
			$(best_version x11-libs/fltk | sed -e 's/^x11-libs\/fltk//'))"
		fltk_flags="
			-DAQSIS_USE_FLTK:BOOL=ON
			-DAQSIS_FLTK_INCLUDE_DIR:PATH=/usr/include/fltk-${fltk_version}
			-DAQSIS_FLTK_LIBRARIES_DIR:PATH=/usr/$(get_libdir)/fltk-${fltk_version}"
	else
		fltk_flags="-DAQSIS_USE_FLTK:BOOL=OFF"
	fi

	if use openexr ; then
		exr_flags="-DAQSIS_USE_OPENEXR:BOOL=ON"
	else
		exr_flags="-DAQSIS_USE_OPENEXR:BOOL=OFF"
	fi

	# The aqsis build system prevents in-source builds, so we make a seperate
	# directory inside ${S} to perform the build.
	mkdir _build
	cd _build

	cmake -DAQSIS_BOOST_LIB_SUFFIX:STRING=-mt \
		${fltk_flags} \
		${exr_flags} \
		-DAQSIS_USE_RPATH:BOOL=OFF \
		-DLIBDIR:STRING=$(get_libdir) \
		-DSYSCONFDIR:STRING=/etc \
		-DCMAKE_INSTALL_PREFIX:PATH=/usr \
		"${S}"

	emake || die "Compilation failed"
}

src_install() {
	cd _build
	emake install DESTDIR="${D}"
	cd ..
	dodoc AUTHORS INSTALL README ReleaseNotes
	# TODO: Make sure examples are installed.
}

