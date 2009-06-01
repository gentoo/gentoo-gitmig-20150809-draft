# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kdetv/kdetv-0.8.9-r2.ebuild,v 1.4 2009/06/01 16:27:02 nixnut Exp $

EAPI="2"

ARTS_REQUIRED="never"

LANGS="bg ca br da de cs cy el es et fi ga fr gl hu is it lt nb mt nl pa pl pt ro ru rw ta sr sv tr en_GB pt_BR zh_CN sr@Latn"
LANGS_DOC="da et fr it nl pt ru sv"

USE_KEG_PACKAGING=1

inherit flag-o-matic kde

DESCRIPTION="A TV application for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=11602"
SRC_URI="http://dziegel.free.fr/releases/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="amd64 ppc x86"
IUSE="lirc zvbi opengl"

RDEPEND="
	!${CATEGORY}/${PN}:0
	zvbi? ( >=media-libs/zvbi-0.2.4 )
	lirc? ( app-misc/lirc )
	opengl? ( virtual/opengl x11-libs/qt[opengl] )
	media-libs/alsa-lib
	x11-libs/libICE
	x11-libs/libXxf86dga
	x11-libs/libXrandr
	x11-libs/libX11
	x11-libs/libXv
	x11-libs/libSM
	x11-libs/libXxf86vm
	x11-libs/libXext
	x11-libs/libXrender"

DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto
	x11-proto/videoproto
	virtual/os-headers"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/${P}-xinerama.patch"
	"${FILESDIR}/kdetv-0.8.9-desktop-entry.diff"
	)

src_configure() {
	local myconf="$(use_enable lirc kdetv-lirc)
		$(use_with zvbi) $(use_with opengl gl)"
	#Filtering the below on x86 and amd64 for bug #145754 and bug #153721
	if [[ ( "$ARCH" == "x86" ) || ( "$ARCH" == "amd64" ) ]]; then
		filter-flags -fforce-addr
	fi
	append-flags -fno-strict-aliasing

	rm -f "${S}"/configure

	kde_src_configure
}
