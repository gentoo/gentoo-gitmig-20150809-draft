# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aqsis/aqsis-1.2.0.ebuild,v 1.3 2007/07/12 04:08:47 mr_bones_ Exp $

inherit versionator multilib

DESCRIPTION="Open source RenderMan-compliant 3D rendering solution"
HOMEPAGE="http://www.aqsis.org"
MY_P="${PN}-$(delete_version_separator 3 ${PV})"
SRC_URI="http://download.aqsis.org/stable/source/tar/${MY_P}.tar.gz"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3 ${PV})"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
# TODO: test on ~x86
IUSE="fltk openexr"

RDEPEND="
	>=media-libs/tiff-3.7.1
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.4
	fltk? ( >=x11-libs/fltk-1.1.0 )
	openexr? ( media-libs/openexr )"

DEPEND="
	${RDEPEND}
	dev-libs/libxslt
	>=dev-libs/boost-1.32.0
	>=sys-devel/flex-2.5.4
	sys-devel/bison
	>=dev-util/scons-0.96.1"

src_compile() {

	if use fltk ; then
		# hack to get fltk library/include paths
		# (upstream currently doesn't autodetect the gentoo install path correctly)
		fltk_version="$(get_version_component_range 1-2 \
			$(best_version x11-libs/fltk | sed -e 's/^x11-libs\/fltk//'))"
		fltk_flags="
			no_fltk=no
			fltk_include_path=/usr/include/fltk-${fltk_version}
			fltk_lib_path=/usr/$(get_libdir)/fltk-${fltk_version}"
	else
		fltk_flags="no_fltk=yes"
	fi

	if use openexr ; then
		exr_flags="
			no_exr=no
			exr_include_path=/usr/include/OpenEXR
			exr_lib_path=/usr/$(get_libdir)"
	else
		exr_flags="no_exr=yes"
	fi

	scons destdir=${D} \
		install_prefix=/usr \
		sysconfdir=/etc \
		libdir="\$install_prefix/$(get_libdir)" \
		no_rpath=true \
		${fltk_flags} \
		${exr_flags} \
		build \
		|| die "Build failed"

		# Option for quickly testing the compile stage
		# cachedir="/tmp/scons_aq_cache" \
}

src_install() {
	scons install
	dodoc AUTHORS COPYING INSTALL README ReleaseNotes
	# remove a few unwanted files from the std. aqsis install
	rm $(find ${D}/usr/share/aqsis/content -name '*.bat')
}
