# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tdtd/tdtd-0.7.1.ebuild,v 1.2 2004/03/14 12:46:10 dholm Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs Major Mode for SGML and XML DTDs"
HOMEPAGE="http://www.menteith.com/tdtd/"
SRC_URI="http://www.menteith.com/tdtd/data/${PN}${PV//./}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/emacs"

SITEFILE=50tdtd-gentoo.el

S=${WORKDIR}

src_compile() {

	export EMACSLOADPATH=.:/usr/share/emacs/21.3/lisp
	emacs --batch -l font-lock -l mail/sendmail -f batch-byte-compile --no-init-file *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc TODO changelog.txt readme.txt tutorial.txt
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
