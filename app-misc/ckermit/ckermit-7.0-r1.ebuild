# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/ckermit/ckermit-7.0-r1.ebuild,v 1.4 2002/07/25 16:55:21 seemant Exp $

MY_P=cku197
S=${WORKDIR}
DESCRIPTION="C-Kermit is a combined serial and network communication software package offering a consistent, medium-independent, cross-platform approach to connection establishment, terminal sessions, file transfer, character-set translation, numeric and alphanumeric paging, and automation of communication tasks."
SRC_URI="ftp://kermit.columbia.edu/kermit/archives/${MY_P}.tar.gz"
HOMEPAGE="http://www.kermit-project.org/"

SLOT="0"
LICENSE="Kermit"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack () {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
	cp makefile makefile.orig
	sed -e "s:-O:$CFLAGS:" makefile.orig > makefile
}

src_compile() {

	make KFLAGS="-DCK_SHADOW" linux || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/share/doc/${P}
	make \
		DESTDIR=${D} \
		BINDIR=/usr/bin \
		MANDIR=/usr/share/man/man1 \
		INFODIR=${D}/usr/share/doc/${P} \
		MANEXT=1 \
		install || die
}
