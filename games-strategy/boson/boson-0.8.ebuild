# Copyright 1999-2003 Gentoo Technologies, Inc. and Thomas Capricelli <orzel@kde.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boson/boson-0.8.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

inherit kde
need-kde 3

DESCRIPTION="real-time strategy game, with the feeling of Command&Conquer(tm) (needs at least 2 ppl to play)"
SRC_URI="mirror://sourceforge/boson/boson-all-${PV}.tar.bz2"
HOMEPAGE="http://boson.eu.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc"
IUSE="opengl"

DEPEND="${DEPEND}
	>=kde-base/kdegames-3.0
	>=kde-base/kdemultimedia-3.0
	media-libs/lib3ds
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}
	dev-lang/wml"

S=${WORKDIR}/${PN}-all-${PV}

src_compile() {
	./configure \
		--disable-debug \
		--with-xinerama \
		`use_with opengl gl` \
		--host=${CHOST} \
		--prefix=${KDEDIR} \
		|| die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
