# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.37_pre20041220.ebuild,v 1.4 2004/01/30 05:45:03 drobbins Exp $

inherit games eutils

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://emuhost.com/ipher/zsnes/"
SRC_URI="http://ipher.emuhost.com/files/zsnes/ZSNESS_${PV/*2004}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="opengl"

RDEPEND="opengl? ( virtual/opengl )
	virtual/x11
	>=media-libs/libsdl-1.2.0
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98
	sys-devel/automake
	>=sys-devel/autoconf-2.58"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	for f in * ; do
		mv ${f} ${f/zsnes\\\\}
	done
	cd src
	edos2unix config.{guess,sub} effects/smoke.c zip/unzip.c
	aclocal || die "aclocal failed"
	env WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
}

src_compile() {
	# Do NOT introduce custom ${CFLAGS}.
	# Current choices are the optimal ones
	cd src
	egamesconf `use_with opengl` || die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/zsnes
	newman src/linux/zsnes.1 zsnes.6
	dodoc *.txt linux/*
	prepgamesdirs
}
