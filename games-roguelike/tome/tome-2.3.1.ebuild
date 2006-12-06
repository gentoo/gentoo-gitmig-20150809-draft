# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/tome/tome-2.3.1.ebuild,v 1.5 2006/12/06 19:25:46 wolf31o2 Exp $

inherit eutils games

MY_PV=${PV//./}
DESCRIPTION="save the world from Morgoth and battle evil (or become evil ;])"
HOMEPAGE="http://t-o-m-e.net/"
SRC_URI="http://t-o-m-e.net/dl/src/tome-${MY_PV}-src.tar.bz2"

LICENSE="Moria"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc-macos x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5
	x11-libs/libX11"
DEPEND="${REDEPEND}
	x11-misc/makedepend"

S="${WORKDIR}/tome-${MY_PV}-src"

src_unpack() {
	unpack ${A}
	cd "${S}/src"
	mv makefile.std makefile
	epatch "${FILESDIR}/${PV}-gentoo-paths.patch"
	sed -i \
		-e "s:GENTOO_DIR:${GAMES_STATEDIR}:" files.c init2.c \
		|| die "sed failed"
	#bug #53640
	sed -i \
		-e "s:-DUSE_X11:-DUSE_GCU -DUSE_X11:" \
		-e "s:-lX11:-lncurses -lX11:" \
		makefile \
		|| die "sed failed"
	find "${S}" -name .cvsignore -exec rm -f \{\} \;
	find "${S}/lib/edit" -type f -exec chmod a-x \{\} \;
}

src_compile() {
	cd src
	make depend || die "make depend failed"
	emake ./tolua || die "emake ./tolua failed"
	emake \
		COPTS="${CFLAGS}" \
		BINDIR="${GAMES_BINDIR}" \
		LIBDIR="${GAMES_DATADIR}/${PN}" \
		|| die "emake failed"
}

src_install() {
	cd src
	make \
		DESTDIR="${D}" \
		OWNER="${GAMES_USER}" \
		BINDIR="${GAMES_BINDIR}" \
		LIBDIR="${GAMES_DATADIR}/${PN}" install \
		|| die "make install failed"
	cd "${S}"
	dodoc *.txt

	dodir "${GAMES_STATEDIR}"
	touch "${D}/${GAMES_STATEDIR}/${PN}-scores.raw"
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}/${PN}-scores.raw"
	#FIXME: something has to be done about this.
	fperms g+w "${GAMES_DATADIR}/${PN}/data"
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "ToME ${PV} is not save-game compatible with previous versions."
	echo
	einfo "If you have older save files and you wish to continue those games,"
	einfo "you'll need to remerge the version of ToME with which you started"
	einfo "those save-games."
}
