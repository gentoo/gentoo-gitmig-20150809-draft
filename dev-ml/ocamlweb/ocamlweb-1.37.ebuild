# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlweb/ocamlweb-1.37.ebuild,v 1.3 2008/03/03 22:51:14 aballier Exp $

DESCRIPTION="O'Caml literate programming tool"
HOMEPAGE="http://www.lri.fr/~filliatr/ocamlweb/"
SRC_URI="http://www.lri.fr/~filliatr/ftp/ocamlweb/${P}.tar.gz"

IUSE=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-lang/ocaml-3.09
	virtual/latex-base
	|| ( dev-texlive/texlive-latexextra
		app-text/tetex
		app-text/ptex
	)"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	emake UPDATETEX="" prefix="${D}/usr" MANDIR="${D}/usr/share/man" install || die
	dodoc README CHANGES
}

tex_regen() {
	einfo "Regenerating TeX database..."
	/usr/bin/mktexlsr /usr/share/texmf /var/spool/texmf > /dev/null
	eend $?
}

pkg_postinst() {
	tex_regen
}

pkg_postrm() {
	tex_regen
}
