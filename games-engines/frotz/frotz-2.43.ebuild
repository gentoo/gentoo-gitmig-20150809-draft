# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/frotz/frotz-2.43.ebuild,v 1.16 2009/01/30 06:49:50 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="Curses based interpreter for Z-code based text games"
HOMEPAGE="http://www.cs.csubak.edu/~dgriffi/proj/frotz/"
SRC_URI="http://www.ifarchive.org/if-archive/infocom/interpreters/frotz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="alsa oss"

DEPEND="sys-libs/ncurses
	alsa? ( oss? ( media-libs/alsa-oss ) )"

src_prepare() {
	sed -i \
		-e '/^CC /d' \
		Makefile \
		|| die 'sed failed'
}

src_compile() {
	local OPTS="CONFIG_DIR=${GAMES_SYSCONFDIR}"
	use oss && OPTS="${MAKE_OPTS} SOUND_DEFS=-DOSS_SOUND SOUND_DEV=/dev/dsp"
	emake ${MAKE_OPTS} all || die "emake failed"
}

src_install () {
	dogamesbin {d,}frotz || die "dogamesbin failed"
	doman doc/*.6
	dodoc AUTHORS BUGS ChangeLog HOW_TO_PLAY README TODO \
		doc/{frotz.conf-big,frotz.conf-small}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "Global config file can be installed in ${GAMES_SYSCONFDIR}/frotz.conf"
	elog "Sample config files are in /usr/share/doc/${PF}"
	echo
}
