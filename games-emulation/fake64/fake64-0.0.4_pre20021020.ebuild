# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fake64/fake64-0.0.4_pre20021020.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games

DESCRIPTION="emulator for nintendo 64"
HOMEPAGE="http://www.fakelabs.org/code/fake64/"
SRC_URI="http://www.fakelabs.org/code/fake64/Fake64-20.10.2002.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/opengl
	virtual/glu
	media-libs/libsdl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:@bindir@/fake64:${S}/blah:" \
		-e 's:/etc/fake64rc:\$(DESTDIR)@sysconfdir@/fake64rc:' \
		Makefile.am
	sed -i "s:/etc/fake64rc:${GAMES_SYSCONFDIR}/fake64rc:" \
		romloader/configfile.c
	touch blah
	./autogen.sh || die "autogen failed"
}

src_compile() {
	econf \
		`use_enable x86` \
		`use_enable mmx` \
		`use_enable 3dnow` \
		`use_enable sse` \
		|| die
	emake || die
}

src_install() {
	dodir /etc
	emake install DESTDIR=${D} || die
	dodoc AUTHORS COMPATIBILITY ChangeLog NEWS README TODO

	cd ${D}/etc
	sed -i "s:/usr/local/fake64/plugins:${GAMES_LIBDIR}/${PN}:" fake64rc
	insinto ${GAMES_SYSCONFDIR}
	doins fake64rc && rm fake64rc
	cd ${D}/usr/fake64
	dogamesbin bin/*
	dosym romloader ${GAMES_BINDIR}/fake64
	dodir ${GAMES_LIBDIR}/${PN}
	mv plugins/* ${D}/${GAMES_LIBDIR}/${PN}/
	cd .. && rm -rf fake64

	prepgamesdirs
}
