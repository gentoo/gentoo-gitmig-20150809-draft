# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/tipa/tipa-1.3.ebuild,v 1.1 2005/02/22 12:51:18 usata Exp $

DESCRIPTION="International Phonetic Alphabet package for LaTeX"
HOMEPAGE="http://www.l.u-tokyo.ac.jp/~fkr/"
SRC_URI="http://www.l.u-tokyo.ac.jp/~fkr/tipa/${P}.tar.gz"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/tetex"

src_compile() {
	# install files under /usr/share/texmf/
	sed -e 's@PREFIX=/usr/local/teTeX/share/texmf@PREFIX=/usr/share/texmf@' \
		-i Makefile || die "sed failed"

	sed -e 's/\($(TEXDIR)\)/$(DESTDIR)\/\1/' \
		-e 's/\($(FONTDIR)\)/$(DESTDIR)\/\1/g' \
		-e 's/\($(MAPDIR)\)/$(DESTDIR)\/\1/' \
		-i Makefile || die "sed failed"

	# removing `mktexlsr` from Makefile (leads to access violation)
	sed -e 's/-mktexlsr//' -i Makefile || die "sed failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed."
	dodoc doc/*.{tex,sty,bib,bbl} || die "dodoc failed."

	einfo "A huge documentation can be found in '/usr/share/doc/${P}'."
}

pkg_postinst() {
	einfo "Running mktexlsr..."
	mktexlsr || die "mktexlsr failed"
}

pkg_postrm() {
	einfo "Running mktexlsr..."
	mktexlsr || die "mktexlsr failed"
}
