# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/typespeed/typespeed-0.4.4.ebuild,v 1.2 2005/01/17 10:13:57 dragonheart Exp $

inherit games toolchain-funcs

DESCRIPTION="Test your typing speed, and get your fingers CPS"
HOMEPAGE="http://ls.purkki.org/typespeed/"
SRC_URI="http://ls.purkki.org/typespeed/${P}.tar.gz"

KEYWORDS="x86 ppc amd64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/01_all_statedir-fix.patch || die "patch failed"
	sed -i -e "s:^CFLAGS =.*:& ${CFLAGS}:" Makefile || \
		die "src_unpack failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die "src_compile failed"
}

src_install() {
	dodir "${GAMES_DATADIR}/${PN}" || die "dodir failed"
	keepdir "${GAMES_STATEDIR}/${PN}" || die "keepdir failed"
	dogamesbin typespeed || die "dogamesbin failed"

	cp ${S}/words* "${D}${GAMES_DATADIR}/${PN}/" || die "copying wordfiles failed"
	dodoc README TODO COPYING Changes BUGS || die "dodoc failed"
	newman typespeed.1 typespeed.6 || die "doman failed"
	prepgamesdirs
}

pkg_preinst() {
	fperms g+s "$GAMES_BINDIR/${PN}" || die "fperms failed"
}

pkg_postinst() {
	cd /var/games/typespeed || die "cd failed"
	# Backup existing scorefiles
	mkdir backup_scores || die "mkdir failed"
	find -maxdepth 1 -name 'high.words.*' -exec mv '{}' backup_scores/ \;
	echo ""
	einfo "Generating scorefiles..."
	echo ""
	/usr/games/bin/typespeed --makescores > /dev/null || die "make scores failed"
	find backup_scores -type f -exec mv -f '{}' . \;
	rmdir backup_scores/ || die "rmdir backup_scores failed"
	chmod g+rw,o-rwx ${PWD}/high*
	games_pkg_postinst
}

pkg_postrm() {
	echo ""
	einfo "${PN} scorefiles was installed into ${GAMES_STATEDIR}/${PN}"
	einfo "and haven't been removed (if this is an uninstall)."
	einfo "To get rid of ${PN} completely, you can safely remove"
	einfo "${GAMES_STATEDIR}/${PN} running:"
	echo ""
	einfo "rm -rf ${GAMES_STATEDIR}/${PN}"
	echo ""
}
