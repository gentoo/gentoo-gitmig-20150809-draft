# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/darktable/darktable-0.9.1-r1.ebuild,v 1.1 2011/08/14 23:38:26 radhermit Exp $

EAPI="4"
if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://darktable.git.sf.net/gitroot/darktable/darktable"
	EGIT_BRANCH="master"
	EGIT_COMMIT="master"
	SCM="git-2"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
GCONF_DEBUG="no"
inherit cmake-utils ${SCM}

DESCRIPTION="A virtual lighttable and darkroom for photographers"
HOMEPAGE="http://darktable.sf.net/"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug flickr gconf gnome-keyring gphoto2 kde nls openmp +rawspeed +slideshow"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/libxml2:2
	flickr? ( media-libs/flickcurl )
	gconf? ( gnome-base/gconf )
	gnome-base/libglade:2.0
	gnome-base/librsvg:2
	gnome-keyring? ( gnome-base/gnome-keyring )
	gphoto2? ( media-libs/libgphoto2 )
	kde? ( dev-libs/dbus-glib )
	media-gfx/exiv2
	media-libs/lcms:2
	>=media-libs/lensfun-0.2.3
	media-libs/libpng
	>=media-libs/libraw-0.13.4[demosaic]
	media-libs/openexr
	media-libs/tiff
	net-misc/curl
	slideshow? (
		media-libs/libsdl
		virtual/opengl
	)
	virtual/jpeg
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	openmp? ( >=sys-devel/gcc-4.4[openmp] )"

PATCHES=(
	"${FILESDIR}"/${PN}-0.9-automagic-deps.patch
	"${FILESDIR}"/${P}-system-libraw.patch
	"${FILESDIR}"/${P}-no-rawspeed.patch
	"${FILESDIR}"/${PN}-0.9-cflags.patch
)

src_prepare() {
	base_src_prepare
	sed -i -e "s:\(/share/doc/\)darktable:\1${PF}:" \
		-e "s:LICENSE::" doc/CMakeLists.txt || die
}

src_configure() {
	use debug && CMAKE_BUILD_TYPE=Debug

	mycmakeargs=(
		$(cmake-utils_use_use flickr FLICKR)
		$(cmake-utils_use_use gconf GCONF_BACKEND)
		$(cmake-utils_use_use gnome-keyring GNOME_KEYRING)
		$(cmake-utils_use_use gphoto2 CAMERA_SUPPORT)
		$(cmake-utils_use_use kde KWALLET)
		$(cmake-utils_use_use nls NLS)
		$(cmake-utils_use_use openmp OPENMP)
		$(cmake-utils_use !rawspeed DONT_USE_RAWSPEED)
		$(cmake-utils_use_build slideshow SLIDESHOW)
		-DDONT_INSTALL_GCONF_SCHEMAS=ON
		-DINSTALL_IOP_EXPERIMENTAL=ON
		-DINSTALL_IOP_LEGACY=ON
	)
	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
	newicon data/pixmaps/48x48/darktable.png darktable.png
}
