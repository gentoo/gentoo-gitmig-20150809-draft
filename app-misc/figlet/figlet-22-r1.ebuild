# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/figlet/figlet-22-r1.ebuild,v 1.6 2003/04/23 14:31:39 vapier Exp $

MY_P=${P/-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="program for making large letters out of ordinary text"
HOMEPAGE="http://www.figlet.org/"
SRC_URI="ftp://ftp.figlet.org/pub/figlet/program/unix/${MY_P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc sparc ~alpha ~mips hppa ~arm"

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	sed -i "s/CFLAGS = -g/CFLAGS = ${CFLAGS}/g" Makefile
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
		install || die

	dodoc Artistic-license.txt FTP-NOTE README showfigfonts figmagic figfont.txt
}
