# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/frotz/frotz-2.43.ebuild,v 1.1 2003/09/09 17:34:21 vapier Exp $

DESCRIPTION="Curses based interpreter for Z-code based text games"
HOMEPAGE="http://www.cs.csubak.edu/~dgriffi/proj/frotz/"
SRC_URI="http://www.ifarchive.org/if-archive/infocom/interpreters/frotz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="oss alsa"

DEPEND="sys-libs/ncurses
	alsa? ( oss? ( media-libs/alsa-oss ) )"

src_compile() {
	local MAKE_OPTS="CONFIG_DIR=/etc"
	use oss && MAKE_OPTS="${MAKE_OPTS} SOUND_DEFS=-DOOS_SOUND"
	emake ${MAKE_OPTS} || die
}

src_install () {
	into /usr
	dobin frotz
	doman frotz.6
	dodoc AUTHORS BUGS COPYING ChangeLog HOW_TO_PLAY INSTALL NOTES README TODO

	insinto /usr/share/${P}/
	doins frotz.conf-big frotz.conf-small
}
