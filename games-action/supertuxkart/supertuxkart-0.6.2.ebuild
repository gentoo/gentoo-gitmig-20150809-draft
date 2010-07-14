# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/supertuxkart/supertuxkart-0.6.2.ebuild,v 1.7 2010/07/14 21:30:51 scarabeus Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="A kart racing game starring Tux, the linux penguin (TuxKart fork)"
HOMEPAGE="http://supertuxkart.sourceforge.net/"
SRC_URI="mirror://sourceforge/supertuxkart/files/SuperTuxKart/${PV}/${P}-src.tar.bz2
	mirror://gentoo/${PN}.png"

LICENSE="GPL-3 CCPL-Attribution-ShareAlike-3.0 CCPL-Attribution-2.0 CCPL-Sampling-Plus-1.0 public-domain as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

RDEPEND=">=media-libs/plib-1.8.4
	virtual/opengl
	virtual/glut
	virtual/glu
	net-libs/enet:0
	media-libs/libmikmod
	media-libs/libvorbis
	media-libs/openal
	media-libs/libsdl[X,video,audio,joystick]
	virtual/libintl"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	esvn_clean
	sed -i \
		-e '/ENETTREE/d' \
		-e '/src\/enet\/Makefile/d' \
		-e '110 i\   AC_SEARCH_LIBS(gluLookAt, GLU)' \
		configure.ac \
		|| die "sed failed"
	sed -i \
		-e '/SUBDIRS/s/doc//' \
		-e '/pkgdata/d' \
		Makefile.am \
		|| die "sed failed"
	sed -i \
		-e '/pkgdatadir/s:/games::' \
		-e '/desktop/d' \
		-e '/icon/d' \
		$(find data -name Makefile.am) \
		|| die "sed failed"
	sed -i \
		-e '/bindir/d' \
		-e '/AM_CPPFLAGS/s:/games::' \
		src/Makefile.am \
		|| die "sed failed"
	# bug #328021
	sed -i \
		-e '13d' \
		data/Makefile.am \
		|| die "sed failed"
	rm -rf src/enet
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} SuperTuxKart
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
