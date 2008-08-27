# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-2.0_p20061118.ebuild,v 1.6 2008/08/27 08:41:25 ulm Exp $

inherit elisp eutils

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 xref.lisp"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc"

RDEPEND="virtual/commonlisp"
DEPEND="${RDEPEND}
	doc? ( virtual/texi2dvi )"

CLPACKAGE=swank
SITEFILE=70${PN}-gentoo.el

src_compile() {
	elisp-compile *.el || die
	use doc && make -C doc slime.info
}

src_install() {
	elisp-install ${PN} *
	elisp-site-file-install "${FILESDIR}"/${PV}/${SITEFILE}
	dodoc README* ChangeLog HACKING NEWS PROBLEMS
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/emacs/site-lisp/${PN}/swank.asd \
		/usr/share/common-lisp/systems/
	if use doc; then
		doinfo doc/slime.info
	fi
}
