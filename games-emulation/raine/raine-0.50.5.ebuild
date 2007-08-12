# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/raine/raine-0.50.5.ebuild,v 1.1 2007/08/12 04:14:41 mr_bones_ Exp $

inherit versionator games

MY_PV=$(replace_version_separator 3 '-')

DESCRIPTION="R A I N E  M680x0 Arcade Emulation"
HOMEPAGE="http://www.rainemu.com/"
SRC_URI="http://www.rainemu.com/html/archive/raines-${MY_PV}.tar.bz2
	http://www.rainemu.com/html/archive/rainedocs.zip
	http://www.rainemu.com/html/archive/icons.zip"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE="static kde"

RDEPEND="media-libs/allegro
	media-libs/libsdl
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-lang/nasm
	app-arch/unzip"

S=${WORKDIR}/${PN}-$(get_version_component_range -3)

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo > detect-cpu
	echo > cpuinfo
	sed -i \
		-e "/prefix =/s:/usr::" \
		-e "/bindir/s:=.*:=\$(DESTDIR)${GAMES_BINDIR}:" \
		-e "/sharedir =/s:=.*:=\$(DESTDIR)${GAMES_DATADIR}:" \
		-e "/mandir/s:=.*:=\$(DESTDIR)/usr/share/man/man6:" \
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
		${myopts} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	keepdir "${GAMES_DATADIR}"/${PN}/{roms,artwork,emudx}
	dodoc "${WORKDIR}/raine.txt"

	insinto /usr/share/icons
	doins "${WORKDIR}/"*.png
	if use kde ; then
		insinto /usr/share/applnk/Games
		doins "${FILESDIR}/Raine.desktop"
	fi
	prepgamesdirs
}
