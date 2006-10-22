# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/powermanga/powermanga-0.80.ebuild,v 1.6 2006/10/22 06:22:43 vapier Exp $

inherit eutils games

DESCRIPTION="An arcade 2D shoot-em-up game"
HOMEPAGE="http://linux.tlk.fr/"
SRC_URI="http://linux.tlk.fr/games/Powermanga/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-0.11.0
	media-libs/sdl-mixer"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		eerror "${PN} needs sdl-mixer compiled with mikmod use-flag enabled!"
		die "sdl-mixer without mikmod detected"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
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

src_compile() {
	egamesconf --prefix=/usr || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin powermanga || die "dogamesbin failed"
	doman powermanga.6
	dodoc AUTHORS CHANGES README

	insinto "${GAMES_DATADIR}/powermanga/sounds"
	doins sounds/*

	insinto "${GAMES_DATADIR}/powermanga/graphics"
	doins graphics/*

	insinto "${GAMES_DATADIR}/powermanga/texts"
	doins texts/*

	find "${D}${GAMES_DATADIR}/powermanga/" -name "Makefile*" -exec rm -f \{\} \;

	insinto /var/games
	local f
	for f in powermanga.hi-easy powermanga.hi powermanga.hi-hard ; do
		touch "${D}/var/games/${f}" || die "touch ${f} failed"
		fperms 660 "/var/games/${f}" || die "fperms ${f} failed"
	done

	prepgamesdirs
}
