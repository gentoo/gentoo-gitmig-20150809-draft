# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mule-ucs/mule-ucs-0.85_rc3.ebuild,v 1.6 2007/07/04 23:15:28 opfer Exp $

inherit elisp-common

MY_PN="Mule-UCS"

DESCRIPTION="A character code translator."
HOMEPAGE="http://www.m17n.org/mule/
	http://tats.iris.ne.jp/mule-ucs/"
SRC_URI="http://gentoojp.sourceforge.jp/distfiles/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 alpha ppc sparc x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-current"

src_compile() {
	emacs -q --no-site-file -batch -l mucs-comp.el || die "mucs-comp failed"
	(cd lisp/big5conv/
		emacs -q --no-site-file -batch -l big5-comp.el || die "big5-comp failed"
	)
	(cd lisp/jisx0213/
		emacs -q --no-site-file -batch -l x0213-comp.el || die "x0213-comp failed"
	)
}

src_install() {
	cd "${S}/lisp"

	elisp-install ${MY_PN} *.el{,c}
	elisp-install ${MY_PN}/big5conv big5conv/*.el{,c}
	elisp-install ${MY_PN}/jisx0213 jisx0213/*.el{,c}
	elisp-install ${MY_PN}/reldata reldata/*.el

	dodoc ChangeLog MuleUni.txt README README.Unicode
	dodoc ../doc/mule-ucs.sgml ../doc/mule-ucs.texi
	docinto big5conv ; dodoc big5conv/README
	docinto jisx0213 ; dodoc jisx0213/ChangeLog jisx0213/readme.txt
}
