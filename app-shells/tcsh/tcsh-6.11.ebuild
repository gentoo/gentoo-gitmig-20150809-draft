# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/tcsh/tcsh-6.11.ebuild,v 1.14 2004/06/29 04:00:06 vapier Exp $

inherit eutils

S=${WORKDIR}/${P}.00
DESCRIPTION="Enhanced version of the Berkeley C shell (csh)"
HOMEPAGE="http://www.tcsh.org/"
SRC_URI="ftp://ftp.gw.com/pub/unix/tcsh/${P}.tar.gz
	ftp://ftp.astron.com/pub/tcsh/${P}.tar.gz
	ftp://ftp.funet.fi/pub/unix/shells/tcsh/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="perl"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.1
	perl? ( dev-lang/perl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-tc.os.h-gentoo.diff
}

src_compile() {
	econf --prefix=/ || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install install.man || die

	use perl && ( \
		perl tcsh.man2html || die
		dohtml tcsh.html/*.html
	)

	dosym /bin/tcsh /bin/csh
	dodoc FAQ Fixes NewThings Ported README WishList Y2K

	insinto /etc
	doins ${FILESDIR}/csh.cshrc ${FILESDIR}/csh.login
}
