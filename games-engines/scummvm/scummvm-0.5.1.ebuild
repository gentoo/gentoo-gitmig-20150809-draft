# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm/scummvm-0.5.1.ebuild,v 1.4 2004/01/02 18:53:00 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Reimplementation of the SCUMM game engine used in Lucasarts adventures"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE="alsa oggvorbis mad"

DEPEND="media-libs/libsdl
	>=sys-apps/sed-4
	oggvorbis? ( media-libs/libvorbis )
	alsa? ( media-libs/alsa-lib )
	mad? ( media-libs/libmad )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-alsa.patch"
}

src_compile() {
	egamesconf \
		`use_with alsa` \
		`use_with oggvorbis vorbis` \
		`use_with mad` \
		|| die
	if [ `use alsa` ] ; then
		sed -i \
			-e "/^# DEF.*ALSA$/s:# ::" \
			-e "/^# LIBS.*asound$/s:# ::" \
			Makefile || die "sed Makefile (alsa) failed"
	fi
	if [ `use oggvorbis` ] ; then
		sed -i \
			-e "/^# DEF.*VORBIS$/s:# ::" \
			-e "/^# LIBS.*vorbis$/s:# ::" \
			Makefile || die "sed Makefile (oggvorbis) failed"
	fi
	if [ ! `use mad` ] ; then
		sed -i \
			-e "s:^DEF.*MAD$::" \
			-e "s:^LIBS.*mad$::" \
			Makefile || die "sed Makefile (mad) failed"
	fi
	emake || die "emake failed"
}

src_install() {
	dogamesbin scummvm || die "dogamesbin failed"
	doman scummvm.6    || die "doman failed"
	dodoc NEWS README  || die "dodoc failed"
	prepgamesdirs
}
