# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r4.ebuild,v 1.10 2003/03/01 04:09:45 vapier Exp $

S=${WORKDIR}/${P/b/}
DESCRIPTION="Any to PostScript filter"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz"
HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE="nls tetex"

DEPEND=">=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
	tetex? ( >=app-text/tetex-1.0.7 )"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf --sysconfdir=/etc/a2ps `use_enable nls` || die
	emake || die
}

src_install() {
	dodir /usr/share/emacs/site-lisp

	einstall \
		sysconfdir=${D}/etc/a2ps \
		lispdir=${D}/usr/share/emacs/site-lisp \
		|| die

	dodoc ANNOUNCE AUTHORS ChangeLog FAQ NEWS README THANKS TODO
}
