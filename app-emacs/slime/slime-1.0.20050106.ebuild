# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-1.0.20050106.ebuild,v 1.1 2005/01/06 19:40:25 mkennedy Exp $

inherit common-lisp elisp eutils

MY_PV_CVS=${PV:4:4}-${PV:8:2}-${PV:10:2}
MY_PV_BASE=${PV:0:3}

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"
SRC_URI="http://www.common-lisp.net/project/slime/slime-${MY_PV_BASE}.tar.gz
	mirror://gentoo/slime-${MY_PV_BASE}-CVS-${MY_PV_CVS}-gentoo.patch.bz2"
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
	doc? ( virtual/tetex sys-apps/texinfo )"

S=${WORKDIR}/${PN}-${MY_PV_BASE}

CLPACKAGE=swank

src_unpack() {
	unpack ${A}
	epatch slime-${MY_PV_BASE}-CVS-${MY_PV_CVS}-gentoo.patch || die
}

src_compile() {
	# NOTE: slime.el wont byte compile currently (2004-10-10)
#	emacs --batch -q -l <(echo "(add-to-list 'load-path \".\")") \
#		-f batch-byte-compile hyperspec.el slime.el || die
	use doc && make -C doc all slime.pdf
}

src_install() {
	elisp-install ${PN} *.{el,elc} ${FILESDIR}/${PV}/swank-loader.lisp
	elisp-site-file-install ${FILESDIR}/${PV}/70slime-gentoo.el
	dodoc ChangeLog HACKING NEWS PROBLEMS README
	common-lisp-install *.lisp ${FILESDIR}/${PV}/swank.asd ${FILESDIR}/${PV}/swank-loader-init.lisp
	common-lisp-system-symlink
	insinto /usr/share/emacs/site-lisp/slime
	doins ChangeLog
	if use doc; then
		dodoc doc/slime.{ps,pdf}
		doinfo doc/slime.info
	fi
}

pkg_postinst() {
	common-lisp_pkg_postinst
	elisp_pkg_postinst
	while read line; do einfo "${line}"; done <${FILESDIR}/README.Gentoo
	einfo "NOTE: dev-lisp/${P} includes a patch from SLIME ${MY_PV_BASE} to"
	einfo "SLIME CVS ${MY_PV_CVS}."
}

pkg_postrm() {
	common-lisp_pkg_postrm
	elisp_pkg_postrm
}
