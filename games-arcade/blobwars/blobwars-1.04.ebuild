# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blobwars/blobwars-1.04.ebuild,v 1.9 2007/02/14 03:08:46 nyhm Exp $

inherit eutils games

DESCRIPTION="Platform game about a blob and his quest to rescue MIAs from an alien invader"
HOMEPAGE="http://www.parallelrealities.co.uk/blobWars.php"
# download page has a lame PHP thing.
SRC_URI="mirror://gentoo/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${PV}-be_pak.diff \
		"${FILESDIR}"/${P}-gcc41.patch
	# bug #137588
	sed -i \
		-e '/strip/d' makefile \
		|| die "sed failed"
}

src_compile() {
	emake \
		DATADIR="${GAMES_DATADIR}/parallelrealities/" \
		DOCDIR="/usr/share/doc/${PF}/" \
		|| die "emake failed"
}

src_install() {
	emake \
		BINDIR="${D}/${GAMES_BINDIR}/" \
		DATADIR="${D}/${GAMES_DATADIR}/parallelrealities/" \
		DOCDIR="${D}/usr/share/doc/${PF}/" \
		ICONDIR="${D}/usr/share/icons/" \
		KDE="${D}/usr/share/applications/" \
		GNOME="${D}/usr/share/applications/" \
		install || die "emake install failed"
	# now make the docs Gentoo friendly.
	dohtml "${D}/usr/share/doc/${PF}/"*
	dodoc "${D}/usr/share/doc/${PF}/"{CHANGES,HACKING,PORTING,README}
	rm -f "${D}/usr/share/doc/${PF}/"*.{png,gif,html} \
		"${D}/usr/share/doc/${PF}/"{CHANGES,HACKING,LICENSE,PORTING,README}
	prepgamesdirs
}
