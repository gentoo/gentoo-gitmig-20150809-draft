# Copyright 1999-2005 Gentoo Foundation and Thomas Capricelli <orzel@kde.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boson/boson-0.9.1.ebuild,v 1.6 2005/01/14 23:38:07 danarmak Exp $

inherit kde

DESCRIPTION="real-time strategy game, with the feeling of Command&Conquer(tm) (needs at least 2 ppl to play)"
HOMEPAGE="http://boson.sourceforge.net/"
SRC_URI="mirror://sourceforge/boson/boson-all-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc -sparc"
IUSE="opengl"

DEPEND="|| ( kde-base/kdegames-meta >=kde-base/kdegames-3.0 )
	|| ( kde-base/kdemultimedia-meta >=kde-base/kdemultimedia-3.0 )
	media-libs/lib3ds
	opengl? ( virtual/opengl )"
need-kde 3

S=${WORKDIR}/${PN}-all-${PV}

src_compile() {
	./configure \
		--disable-debug \
		--with-xinerama \
		`use_with opengl gl` \
		--host=${CHOST} \
		--prefix=${KDEDIR} \
		|| die "./configure failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
