# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-1.0.ebuild,v 1.3 2005/07/10 00:44:33 swegener Exp $

inherit common-lisp elisp

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"
SRC_URI="http://www.common-lisp.net/project/slime/slime-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

# The doc USE flag governs the creation of PostScript and PDF
# documentation.  GNU Info format documentation will created
# regardless.

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller
	virtual/commonlisp
	doc? ( virtual/tetex )"

CLPACKAGE=swank

src_compile() {
	emacs --batch -q -l <(echo "(add-to-list 'load-path \".\")") \
		-f batch-byte-compile hyperspec.el slime.el || die
	make -C doc contributors.texi slime.info
	use doc && make -C doc slime.ps slime.pdf
}

src_install() {
	elisp-install ${PN} *.{el,elc} ${FILESDIR}/swank-loader.lisp
	elisp-site-file-install ${FILESDIR}/70slime-gentoo.el
	dodoc ChangeLog HACKING NEWS README* PROBLEMS
	common-lisp-install *.lisp ${FILESDIR}/swank.asd
	common-lisp-system-symlink
	insinto /usr/share/emacs/site-lisp/slime
	doins ChangeLog
	doinfo doc/slime.info
	use doc && dodoc doc/slime.{ps,pdf}
}

pkg_postinst() {
	common-lisp_pkg_postinst
	elisp_pkg_postinst
	while read line; do einfo "${line}"; done <${FILESDIR}/README.Gentoo
}

pkg_postrm() {
	common-lisp_pkg_postrm
	elisp_pkg_postrm
}
