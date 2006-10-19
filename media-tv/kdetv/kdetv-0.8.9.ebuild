# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kdetv/kdetv-0.8.9.ebuild,v 1.1 2006/10/19 21:35:04 deathwing00 Exp $

LANGS="bg ca br da de cs cy el es et fi ga fr gl hu is it lt nb mt nl pa pl pt ro ru rw ta sr sv tr en_GB pt_BR zh_CN sr@Latn"
LANGS_DOC="da et fr it nl pt ru sv"

USE_KEG_PACKAGING=1

inherit kde flag-o-matic

DESCRIPTION="A TV application for KDE"
HOMEPAGE="http://www.kdetv.org/"
SRC_URI="http://dziegel.free.fr/releases/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts lirc zvbi opengl"

RDEPEND="zvbi? ( >=media-libs/zvbi-0.2.4 )
	lirc? ( app-misc/lirc )
	opengl? ( virtual/opengl )
	media-libs/alsa-lib
	|| ( ( x11-libs/libICE
		x11-libs/libXxf86dga
		x11-libs/libXrandr
		x11-libs/libX11
		x11-libs/libXv
		x11-libs/libSM
		x11-libs/libXxf86vm
		x11-libs/libXext
		x11-libs/libXrender
		) <virtual/x11-7 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/videoproto <virtual/x11-7 )
	virtual/os-headers"

need-kde 3.2

PATCHES="${FILESDIR}/${P}-xinerama.patch
	${FILESDIR}/${P}-bindnow.patch"

src_compile() {
	local myconf="$(use_enable arts) $(use_enable lirc kdetv-lirc)
		$(use_with zvbi) $(use_with opengl gl)"
	#Filtering the below on x86 for bug #145754
	if [ "$ARCH" == "x86" ]; then
		filter-flags -fforce-addr
	fi
	append-flags -fno-strict-aliasing

	export BINDNOW_FLAGS="$(bindnow-flags)"
	kde_src_compile all
}

src_install() {
	kde_src_install

	# Move the .desktop file in FDO's suggested place
	dodir /usr/share/applications/kde
	mv ${D}/usr/share/applnk/Multimedia/kdetv.desktop \
		${D}/usr/share/applications/kde
}

