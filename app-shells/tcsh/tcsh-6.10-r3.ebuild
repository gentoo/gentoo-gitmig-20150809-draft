# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/tcsh/tcsh-6.10-r3.ebuild,v 1.11 2003/03/11 21:11:45 seemant Exp $

IUSE="perl"
      
S=${WORKDIR}/${P}.00
DESCRIPTION="Enhanced version of the Berkeley C shell (csh)"
SRC_URI="ftp://ftp.gw.com/pub/unix/tcsh/${P}.tar.gz
	ftp://ftp.astron.com/pub/tcsh/${P}.tar.gz
	ftp://ftp.funet.fi/pub/unix/shells/tcsh/${P}.tar.gz"
HOMEPAGE="http://www.tcsh.org/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	perl? ( dev-lang/perl )"

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="BSD"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-tc.os.h-gentoo.diff
}

src_compile() {
	./configure \
		--prefix=/ \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		|| die

	emake || die
}

src_install() {

	make DESTDIR=${D} install install.man || die
	if [ "`use perl`" ]; then
		perl tcsh.man2html || die
		dohtml tcsh.html/*.html
	fi
	dosym tcsh /bin/csh
	dodoc FAQ Fixes NewThings Ported README WishList Y2K

	insinto /etc
	doins ${FILESDIR}/csh.cshrc ${FILESDIR}/csh.login
}
