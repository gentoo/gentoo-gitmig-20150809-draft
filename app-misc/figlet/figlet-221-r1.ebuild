# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/figlet/figlet-221-r1.ebuild,v 1.9 2005/04/07 14:13:06 agriffis Exp $

inherit eutils bash-completion

MY_P=${P/-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="program for making large letters out of ordinary text"
HOMEPAGE="http://www.figlet.org/"
# Bug 35339 - add more fonts to figlet ebuild
# The fonts are available from the figlet site, but they don't
# have versions so we mirror them ourselves.
SRC_URI="ftp://ftp.figlet.org/pub/figlet/program/unix/${MY_P}.tar.gz
	mirror://gentoo/contributed-${P}.tar.gz
	mirror://gentoo/ms-dos-${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc sparc x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${WORKDIR}/contributed/C64-fonts/*.flf fonts/
	cp ${WORKDIR}/contributed/bdffonts/*.flf fonts/
	cp ${WORKDIR}/ms-dos/*.flf fonts/
	cp ${WORKDIR}/contributed/*.flf fonts/

	epatch ${FILESDIR}/${P}-gentoo.diff
	sed -i \
		-e "s/CFLAGS = -g/CFLAGS = ${CFLAGS}/g" Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	make clean || die "make clean failed"
	emake figlet || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/man6
	chmod +x figlist showfigfonts
	make \
		DESTDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man6 \
	    DEFAULTFONTDIR=${D}/usr/share/figlet \
		install || die "make install failed"

	dodoc README figfont.txt || die "dodoc failed"
	dobashcompletion ${FILESDIR}/figlet.bashcomp
}
