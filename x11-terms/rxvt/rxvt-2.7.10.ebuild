# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt/rxvt-2.7.10.ebuild,v 1.1 2003/03/31 19:47:25 dragon Exp $

inherit eutils

IUSE="motif"
S=${WORKDIR}/${P}
DESCRIPTION="rxvt -- nice small x11 terminal"
SRC_URI="ftp://ftp.rxvt.org/pub/rxvt/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~mips"

HOMEPAGE="http://www.rxvt.org"

DEPEND="virtual/glibc
	virtual/x11
	motif? ( x11-libs/openmotif )"


src_unpack() {
	unpack ${A}
	cd ${S}
	
	use motif && epatch ${FILESDIR}/${P}-azz4.diff
}

src_compile() {
	econf \
		--enable-everything \
		--enable-rxvt-scroll \
		--enable-next-scroll \
		--enable-xterm-scroll \
		--enable-transparency \
		--enable-xpm-background \
		--enable-utmp \
		--enable-wtmp \
		--enable-mousewheel \
		--enable-slipwheeling \
		--enable-smart-resize \
		--enable-256-color \
		--enable-menubar \
		--enable-languages \
		--enable-xim \
		--enable-shared \
		--enable-keepscrolling || die

	emake || die
}

src_install() {

	einstall \
		mandir=${D}/usr/share/man/man1 || die
	
	cd ${S}/doc
	dodoc README* *.txt BUGS FAQ
	dohtml *.html
}
