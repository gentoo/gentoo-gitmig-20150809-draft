# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/darktable/darktable-1.1.ebuild,v 1.2 2012/12/09 00:04:51 radhermit Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2 eutils cmake-utils toolchain-funcs

DESCRIPTION="A virtual lighttable and darkroom for photographers"
HOMEPAGE="http://darktable.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="colord debug facebook flickr geo gnome gphoto2 kde nls opencl openmp +rawspeed
+slideshow video_cards_nvidia"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/libxml2:2
	colord? ( x11-misc/colord )
	facebook? ( dev-libs/json-glib )
	flickr? ( media-libs/flickcurl )
	geo? ( net-libs/libsoup:2.4 )
	gnome? (
		gnome-base/gconf
		gnome-base/gnome-keyring
	)
	gnome-base/librsvg:2
	gphoto2? ( media-libs/libgphoto2 )
	kde? (
		dev-libs/dbus-glib
		kde-base/kwalletd
	)
	media-gfx/exiv2[xmp]
	media-libs/lcms:2
	>=media-libs/lensfun-0.2.3
	media-libs/libpng
	>=media-libs/libraw-0.13.4[demosaic]
	media-libs/openexr
	media-libs/tiff
	net-misc/curl
	opencl? ( virtual/opencl )
	slideshow? (
		media-libs/libsdl
		virtual/glu
		virtual/opengl
	)
	virtual/jpeg
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=(
	"${FILESDIR}"/${P}-system-libraw.patch
	"${FILESDIR}"/${P}-opencl-kernels.patch
	"${FILESDIR}"/${P}-cflags.patch
	"${FILESDIR}"/${P}-automagic-colord.patch
)

openmp_check() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

pkg_pretend() {
	openmp_check
}

pkg_setup() {
	openmp_check
}

src_prepare() {
	base_src_prepare
	sed -i -e "s:\(/share/doc/\)darktable:\1${PF}:" \
		-e "s:LICENSE::" doc/CMakeLists.txt || die
}

src_configure() {
	use debug && CMAKE_BUILD_TYPE=Debug

	local mycmakeargs=(
		$(cmake-utils_use_use colord COLORD)
		$(cmake-utils_use_use facebook GLIBJSON)
		$(cmake-utils_use_use flickr FLICKR)
		$(cmake-utils_use_use geo GEO)
		$(cmake-utils_use_use gnome GCONF_BACKEND)
		$(cmake-utils_use_use gnome GNOME_KEYRING)
		$(cmake-utils_use_use gphoto2 CAMERA_SUPPORT)
		$(cmake-utils_use_use kde KWALLET)
		$(cmake-utils_use_use nls NLS)
		$(cmake-utils_use_use openmp OPENMP)
		$(cmake-utils_use !rawspeed DONT_USE_RAWSPEED)
		$(cmake-utils_use_build slideshow SLIDESHOW)
		-DDONT_INSTALL_GCONF_SCHEMAS=$(usex gnome OFF ON)
		-DUSE_OPENCL=$(usex opencl ON OFF)
		-DINSTALL_IOP_EXPERIMENTAL=ON
		-DINSTALL_IOP_LEGACY=ON
	)
	cmake-utils_src_configure
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	cmake-utils_src_install
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	# remove unnecessary file (bug #446516)
	rm "${D}"/usr/share/darktable/js/.DS_Store || die
}
