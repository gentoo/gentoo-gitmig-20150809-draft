# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/mule-ucs/mule-ucs-0.85_rc3.ebuild,v 1.1 2003/05/18 09:05:05 yakina Exp $

MY_P="Mule-UCS-${PV}"
DESCRIPTION="A character code translator."
HOMEPAGE="http://www.m17n.org/mule/
	http://tats.iris.ne.jp/mule-ucs/"
SRC_URI="http://gentoojp.sourceforge.jp/distfiles/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=app-editors/emacs-20.4"
S="${WORKDIR}/${MY_P}"

src_compile() {
	emacs -q --no-site-file -batch -l mucs-comp.el || die
	(cd lisp/big5conv/
		emacs -q --no-site-file -batch -l big5-comp.el || die
	)
	(cd lisp/jisx0213/
		emacs -q --no-site-file -batch -l x0213-comp.el || die
	)
}

src_install() {
	cd ${S}/lisp

	insinto /usr/share/emacs/site-lisp/Mule-UCS/
	insopts -m0644
	doins *.el{,c}

	insinto /usr/share/emacs/site-lisp/Mule-UCS/big5conv/
	doins big5conv/*.el{,c}

	insinto /usr/share/emacs/site-lisp/Mule-UCS/jisx0213/
	doins jisx0213/*.el{,c}

	insinto /usr/share/emacs/site-lisp/Mule-UCS/reldata/
	doins reldata/*.el

	dodoc ChangeLog MuleUni.txt README README.Unicode
	dodoc ../doc/mule-ucs.sgml ../doc/mule-ucs.texi
	docinto big5conv ; dodoc big5conv/README
	docinto jisx0213 ; dodoc jisx0213/ChangeLog jisx0213/readme.txt
}
