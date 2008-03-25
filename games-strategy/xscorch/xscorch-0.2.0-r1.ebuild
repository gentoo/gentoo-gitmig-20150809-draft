# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xscorch/xscorch-0.2.0-r1.ebuild,v 1.4 2008/03/25 15:42:11 coldwind Exp $

inherit eutils games

DESCRIPTION="clone of the classic DOS game, 'Scorched Earth'"
HOMEPAGE="http://xscorch.org"
SRC_URI="http://xscorch.org./releases/${P}.tar.gz
	http://xscorch.org/releases/${P}-stack-smash.patch.gz
	http://xscorch.org./releases/${P}-64bit.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="gtk mikmod"

DEPEND="gtk? ( =x11-libs/gtk+-1* )
	mikmod? ( media-libs/libmikmod )"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch \
		"${DISTDIR}/${P}-64bit.patch.gz" \
		"${DISTDIR}/${P}-stack-smash.patch.gz"
}

src_compile() {
	#configure failed on readline support
	egamesconf \
		--enable-network \
		--without-readline \
		$(use_enable mikmod sound) \
		$(use_with gtk) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	# remove unneeded, empty directory
	rmdir "${D}"/usr/games/include
	prepgamesdirs
}
