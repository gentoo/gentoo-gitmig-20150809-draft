# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/darktable/darktable-9999.ebuild,v 1.1 2011/07/19 19:11:57 c1pher Exp $

EAPI="4"
if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://darktable.git.sf.net/gitroot/darktable/darktable"
	EGIT_BRANCH="master"
	EGIT_COMMIT="master"
	SCM="git-2"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/project/darktable/darktable/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
GCONF_DEBUG="no"
inherit cmake-utils ${SCM}

DESCRIPTION="A virtual lighttable and darkroom for photographers"
HOMEPAGE="http://darktable.sf.net/"

LICENSE="GPL-3"
SLOT="0"

IUSE="gconf gphoto2 openmp gnome-keyring"
RDEPEND="
	gconf? ( gnome-base/gconf )
	gphoto2? ( media-libs/libgphoto2 )
	dev-db/sqlite:3
	dev-libs/libxml2:2
	gnome-base/libglade:2.0
	gnome-keyring? ( gnome-base/gnome-keyring )
	media-gfx/exiv2
	media-libs/lcms:2
	>=media-libs/lensfun-0.2.3
	media-libs/libpng
	gnome-base/librsvg:2
	media-libs/openexr
	media-libs/tiff
	net-misc/curl
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	virtual/jpeg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	openmp? ( >=sys-devel/gcc-4.4[openmp] )"

src_configure() {
	mycmakeargs=(
		"$(cmake-utils_use_use openmp OPENMP)"
		"$(cmake-utils_use_use gconf GCONF_BACKEND)"
		"$(cmake-utils_use_use gphoto2 CAMERA_SUPPORT)"
		"-DDONT_INSTALL_GCONF_SCHEMAS=ON"
		"-DINSTALL_IOP_EXPERIMENTAL=ON"
		"-DINSTALL_IOP_LEGACY=ON" )
	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
	newicon data/pixmaps/48x48/darktable.png darktable.png
}
