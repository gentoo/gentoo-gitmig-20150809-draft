# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/figlet/figlet-221.ebuild,v 1.3 2003/09/05 12:10:36 msterret Exp $

inherit eutils

MY_P=${P/-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="program for making large letters out of ordinary text"
HOMEPAGE="http://www.figlet.org/"
SRC_URI="ftp://ftp.figlet.org/pub/figlet/program/unix/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc sparc ~alpha ~mips ~hppa ~arm"

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	sed -i "s/CFLAGS = -g/CFLAGS = ${CFLAGS}/g" Makefile || \
		die "sed Makefile failed"
}

src_compile() {
	make clean || die
	make figlet || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man6
	chmod +x figlist showfigfonts
	make \
		DESTDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man6 \
	    DEFAULTFONTDIR=${D}/usr/share/figlet \
		install || die "make install failed"

	dodoc Artistic-license.txt README showfigfonts figfont.txt
}
