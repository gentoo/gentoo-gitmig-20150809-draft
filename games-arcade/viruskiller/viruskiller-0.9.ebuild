# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/viruskiller/viruskiller-0.9.ebuild,v 1.8 2004/12/28 11:51:59 josejx Exp $

inherit games flag-o-matic

DESCRIPTION="Simple arcade game, shoot'em up style, where you must defend your file system from invading viruses"
HOMEPAGE="http://www.parallelrealities.co.uk/virusKiller.php"
SRC_URI="${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
RESTRICT="fetch"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf
	dev-libs/zziplib
	dev-util/pkgconfig"

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "http://www.parallelrealities.co.uk/virusKiller.php#Downloads"
	einfo "and save the file in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^BINDIR = /s:/$:/bin/:" \
		-e "/^DOCDIR = /s:doc/.*:doc/${PF}/html/:" \
		-e "s:/usr/bin/zzip-config:pkg-config zziplib:"\
		-e "s:zzip-config:pkg-config zziplib:"\
		makefile || die "Can't patch makefile"
}

src_compile() {
	append-flags -fsigned-char
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	rm ${D}/usr/share/doc/${PF}/html/{README,LICENSE}
	dodoc doc/README
	prepgamesdirs
}
