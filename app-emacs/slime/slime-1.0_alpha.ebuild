# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-1.0_alpha.ebuild,v 1.1 2004/07/25 20:57:03 mkennedy Exp $

inherit common-lisp elisp

MY_PV=${PV/_/}
DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"
SRC_URI="http://www.common-lisp.net/project/slime/slime-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/emacs
	dev-lisp/common-lisp-controller
	virtual/commonlisp"

S="${WORKDIR}/${PN}-${MY_PV}"

CLPACKAGE=swank

src_compile() {
	echo "(add-to-list 'load-path \".\")" >script
	emacs --batch -q -l script -f batch-byte-compile hyperspec.el slime.el || die
}

src_install() {
	elisp-install ${PN} *.{el,elc} ${FILESDIR}/swank-loader.lisp
	elisp-site-file-install ${FILESDIR}/70slime-gentoo.el
	dodoc ChangeLog HACKING NEWS README*
	common-lisp-install *.lisp ${FILESDIR}/swank.asd ChangeLog
	common-lisp-system-symlink
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
