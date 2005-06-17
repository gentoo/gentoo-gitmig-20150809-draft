# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/emacs-cl-cvs/emacs-cl-cvs-0.ebuild,v 1.1 2005/06/17 17:30:34 mkennedy Exp $

ECVS_SERVER="cvs.nocrew.org:/usr/local/cvsroot"
if [ -z "${ECVS_BRANCH}" ]; then
	ECVS_BRANCH="HEAD"
fi
ECVS_MODULE="emacs-cl"
ECVS_USER="anonymous"
ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

IUSE=""

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="Emacs Common Lisp is an implementation of Common Lisp written in Emacs Lisp."
SRC_URI=""
HOMEPAGE="http://www.lisp.se/emacs-cl/
	http://www.emacswiki.org/cgi-bin/wiki?EmacsCommonLisp
	http://www.cliki.net/emacs-cl"

DEPEND="virtual/emacs"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

src_compile() {
	make EMACS=/usr/bin/emacs || die
}

src_install() {
	elisp-install emacs-cl *.{el,elc}
	elisp-site-file-install ${FILESDIR}/50emacs-cl-gentoo.el
	dobin ${FILESDIR}/emacs-cl
	dodoc HACKING HOWTO README BUGS COPYING
}
