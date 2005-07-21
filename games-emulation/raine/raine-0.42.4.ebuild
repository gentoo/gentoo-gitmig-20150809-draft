# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/raine/raine-0.42.4.ebuild,v 1.1 2005/07/21 02:22:49 mr_bones_ Exp $

inherit games

DESCRIPTION="R A I N E  M680x0 Arcade Emulation"
HOMEPAGE="http://www.rainemu.com/"
SRC_URI="http://www.rainemu.com/html/archive/raines-${PV}.tar.bz2
	http://www.rainemu.com/html/archive/rainedocs.zip
	http://www.rainemu.com/html/archive/icons.zip"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE="static kde"

RDEPEND="media-libs/allegro
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo > detect-cpu
	echo > cpuinfo
	sed -i \
		-e "/bindir/s:/usr/games:${GAMES_BINDIR}:" \
		makefile \
		|| die "sed failed"
}

src_compile() {
	local myopts=
	use static \
		&& myopts="${myopts} STATIC=1" \
		|| myopts="${myopts} STATIC="
	emake \
		_MARCH="${CFLAGS}" \
		OSTYPE=linux \
		${myopts} || die "emake failed"
}

src_install() {
	make prefix="${D}" install || die "make install failed"
	keepdir "${GAMES_DATADIR}/${PN}/roms"
	dodoc "${WORKDIR}/raine.txt"

	insinto /usr/share/icons
	doins "${WORKDIR}/"*.png
	if use kde ; then
		insinto /usr/share/applnk/Games
		doins "${FILESDIR}/Raine.desktop"
	fi
	prepgamesdirs
}
