# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/hearse/hearse-1.5.ebuild,v 1.2 2005/05/09 15:41:53 dholm Exp $

inherit games

DESCRIPTION="exchange Nethack bones files with other players"
HOMEPAGE="http://www.argon.org/~roderick/hearse/"
SRC_URI="http://www.argon.org/~roderick/hearse/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND=">=games-roguelike/nethack-3.4.1
	>=dev-lang/perl-5.8.0
	dev-perl/libwww-perl
	app-arch/bzip2"
DEPEND=">=dev-lang/perl-5.8.0
	dev-perl/libwww-perl
	app-arch/bzip2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch because Gentoo's nethack ebuild uses bz2 and not gz for bones
	sed -i \
		-e "s:gzip :bzip2 :" \
		-e "s:.gz:.bz2:" hearse \
			|| die "sed failed"
	sed -i \
		-e 's:gzip :bzip2 :' \
		-e "s:gz|z|Z:bz2:" bones-info \
			|| die "sed failed"
}
src_compile() {
	perl Makefile.PL || die "perl failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin hearse bones-info || die "dogamesbin failed"
	doman blib/man1/*.1
	dodoc Notes README debian/changelog
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "As root, run \"${GAMES_BINDIR}/hearse --user-email your@address.com\" to activate."
	einfo "Add the following to /etc/crontab to automatically exchange bones:"
	einfo "   0 3 * * * root perl -we 'sleep rand 3600'; ${GAMES_BINDIR}/hearse --quiet"
}
