# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xscorch/xscorch-0.1.16_rc2.ebuild,v 1.3 2004/02/03 20:35:35 mr_bones_ Exp $

inherit eutils games

S="${WORKDIR}/xscorch-0.1.15"
DESCRIPTION="clone of the classic DOS game, 'Scorched Earth'"
HOMEPAGE="http://chaos2.org/xscorch/"
SRC_URI="http://chaos2.org/xscorch/${PN}-0.1.15.tar.gz
	http://utoxin.kydance.net/xscorch/${PN}-0.1.15.tar.gz
	http://chaos2.org/xscorch/xscorch-0.1.15-0.1.16pre2.patch.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha"
SLOT="0"

IUSE="gtk mikmod readline gnome"

RDEPEND="virtual/x11
	gtk? ( =x11-libs/gtk+-1* )
	mikmod? ( >=media-libs/libmikmod-3.1.5 )
	readline? ( sys-libs/readline )
	gnome? ( gnome-base/gnome-libs )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	local HELPFILE="${GAMES_DATADIR}/${PN}/xscorch.help"

	unpack ${A}
	cd ${WORKDIR}
	epatch xscorch-0.1.15-0.1.16pre2.patch
	cp ${S}/doc/xscorch.6 ${S}/xscorch.help || \
		die "xscorch.help creation failed"
	sed -i \
		-e "/SC_GROFF_MANUAL_FILE/ s:@mandir@/man6/xscorch.6:${HELPFILE}:" \
			${S}/xscorch.h.in || die "sed xscorch.h.in failed"

}

src_compile() {
	local myconf=""
	use mikmod \
		&& myconf="--enable-sound=yes" \
		|| myconf="--enable-sound=no"
	egamesconf \
		--enable-network \
		--with-readline=maybe \
		`use_with gtk` \
		`use_with gnome` \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins xscorch.help || die "doins failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	prepgamesdirs
}
