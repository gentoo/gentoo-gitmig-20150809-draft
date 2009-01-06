# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/powermanga/powermanga-0.90.ebuild,v 1.5 2009/01/06 21:51:49 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="An arcade 2D shoot-em-up game"
HOMEPAGE="http://linux.tlk.fr/"
SRC_URI="http://linux.tlk.fr/games/Powermanga/download/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-0.11.0
	media-libs/sdl-mixer[mikmod]"

src_prepare() {
	sed -i -e "/null/d" graphics/Makefile.in || die "sed failed"
	sed -i -e "/zozo/d" texts/text_en.txt || die "sed failed"
	local f
	for f in src/assembler.S src/assembler_opt.S ; do
		cat <<-EOF >> ${f}
		#ifdef __ELF__
		.section .note.GNU-stack,"",%progbits
		#endif
		EOF
	done
}

src_configure() {
	egamesconf --prefix=/usr || die "egamesconf failed"
}

src_install() {
	dogamesbin powermanga || die "dogamesbin failed"
	doman powermanga.6
	dodoc AUTHORS CHANGES README

	insinto "${GAMES_DATADIR}/powermanga"
	doins -r data sounds graphics texts || die "doins failed"

	find "${D}${GAMES_DATADIR}/powermanga/" -name "Makefil*" -exec rm -f \{\} \;

	insinto /var/games
	local f
	for f in powermanga.hi-easy powermanga.hi powermanga.hi-hard ; do
		touch "${D}/var/games/${f}" || die "touch ${f} failed"
		fperms 660 "/var/games/${f}" || die "fperms ${f} failed"
	done

	make_desktop_entry powermanga Powermanga
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "NOTE: The highscore file format has changed."
	ewarn "Older highscores will not be retained."
}
