# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/psh/psh-0.009-r1.ebuild,v 1.16 2004/06/29 03:56:45 vapier Exp $

DESCRIPTION="Combines the interactive nature of a Unix shell with the power of Perl"
HOMEPAGE="http://www.focusresearch.com/gregor/psh/"
SRC_URI="http://www.focusresearch.com/gregor/psh/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=dev-lang/perl-5"

src_compile() {
	perl Makefile.PL
	make || die
}

src_install() {
	make PREFIX=${D}/usr \
		prefix=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		install || die

	dodoc HACKING MANIFEST README* RELEASE TODO
	dodoc examples/complete-examples
}
