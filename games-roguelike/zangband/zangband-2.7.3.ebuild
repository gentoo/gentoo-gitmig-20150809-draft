# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/zangband/zangband-2.7.3.ebuild,v 1.1 2003/09/10 04:59:58 vapier Exp $

inherit games

DESCRIPTION="An enhanced version of the Roguelike game Angband"
HOMEPAGE="http://www.zangband.org/"
SRC_URI="ftp://clockwork.dementia.org/angband/Variant/ZAngband/${P}.tar.gz"

SLOT="0"
LICENSE="Moria GPL-2"
KEYWORDS="x86 ppc"
IUSE="X"

DEPEND=">=sys-libs/ncurses-5
	>=sys-apps/sed-4
	X? ( >=x11-base/xfree-4.0 )"

S=${WORKDIR}/${PN}

src_compile() {
	# Version 2.7.3 won't configure without this
	export WANT_AUTOCONF_2_5=1

	local myconf="--with-setgid=${GAMES_GROUP}"
	use X || myconf="${myconf} --without-x"

	# Bootstrap and configure Zangband
	./bootstrap || die "bootstrapping failed"
	egamesconf ${myconf} || die

	# This fixes the games/games bug
	sed -i "s:${GAMES_DATADIR}:/usr/share:" makefile
	emake || die
}

src_install() {
	# Keep some important dirs we want to chmod later
	keepdir ${GAMES_DATADIR}/zangband/lib/apex
	keepdir ${GAMES_DATADIR}/zangband/lib/user
	keepdir ${GAMES_DATADIR}/zangband/lib/save

	# Install the basic files but remove unneeded crap
	make DESTDIR=${D}/${GAMES_DATADIR}/zangband/ installbase || die
	rm ${D}/${GAMES_DATADIR}/zangband/{angdos.cfg,readme,z_faq.txt,z_update.txt}

	# Install everything else and fix the permissions
	exeinto /usr/games/bin
	doexe zangband
	dodoc readme z_faq.txt z_update.txt

	prepgamesdirs
	# All users in the games group need write permissions to some important dirs
	chmod -R g+w ${D}/${GAMES_DATADIR}/zangband/lib/{apex,save,user}
}
