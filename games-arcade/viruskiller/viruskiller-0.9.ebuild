# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/viruskiller/viruskiller-0.9.ebuild,v 1.10 2005/05/07 23:47:16 vapier Exp $

inherit games flag-o-matic

DESCRIPTION="Simple arcade game, shoot'em up style, where you must defend your file system from invading viruses"
HOMEPAGE="http://www.parallelrealities.co.uk/virusKiller.php"
SRC_URI="${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RESTRICT="fetch"

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf
	dev-libs/zziplib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "http://www.parallelrealities.co.uk/virusKiller.php#Downloads"
	einfo "and save the file in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
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
	make \
		DESTDIR="${D}" \
		ICONDIR="${D}"/usr/share/pixmaps/ \
		KDE="${D}"/usr/share/applications/ \
		GNOME="${D}"/usr/share/applications/ \
		install || die
	rm -f "${D}"/usr/share/doc/${PF}/html/{README,LICENSE}
	dodoc doc/README
	prepgamesdirs
}
