# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kdetv/kdetv-0.8.8-r1.ebuild,v 1.3 2006/01/12 13:20:27 flameeyes Exp $

inherit kde

DESCRIPTION="A TV application for KDE"
HOMEPAGE="http://www.kwintv.org/"
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
		) virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( (
		x11-proto/videoproto
		x11-proto/xproto
		x11-proto/xextproto
		) virtual/x11 )
	virtual/os-headers"

need-kde 3.2

PATCHES="${FILESDIR}/${P}-xinerama.patch"

src_unpack() {
	LANGS="bg ca br da de cs cy el es et fi ga fr gl hu is it lt nb mt nl pa pl pt ro ru rw ta sr sv tr en_GB pt_BR zh_CN sr@Latn"
	LANGS_DOC="da et fr it nl pt ru sv"

	MAKE_PO=$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))
	MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d))

	kde_src_unpack
	sed -i -r -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_PO}:" ${S}/po/Makefile.in || die "sed for locale failed"
	sed -i -r -e "s:^SUBDIRS =.*:SUBDIRS = \. ${MAKE_DOC} kdetv:" ${S}/doc/Makefile.in || die "sed for locale failed"

	rm -f ${S}/configure
}

src_compile() {
	local myconf="$(use_enable arts) $(use_enable lirc kdetv-lirc)
		$(use_with zvbi) $(use_with opengl gl)"
	kde_src_compile all
}
