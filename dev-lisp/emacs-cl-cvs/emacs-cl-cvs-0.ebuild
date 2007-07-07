# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/emacs-cl-cvs/emacs-cl-cvs-0.ebuild,v 1.2 2007/07/07 13:51:43 ulm Exp $

ECVS_SERVER="cvs.nocrew.org:/usr/local/cvsroot"
if [ -z "${ECVS_BRANCH}" ]; then
	ECVS_BRANCH="HEAD"
fi
ECVS_MODULE="emacs-cl"
ECVS_USER="anonymous"
ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

DESCRIPTION="Emacs Common Lisp is an implementation of Common Lisp written in Emacs Lisp."
HOMEPAGE="http://www.lisp.se/emacs-cl/
	http://www.emacswiki.org/cgi-bin/wiki?EmacsCommonLisp
	http://www.cliki.net/emacs-cl"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

SITEFILE=50emacs-cl-gentoo.el

S="${WORKDIR}/${ECVS_MODULE}"

src_compile() {
	make EMACS=/usr/bin/emacs || die
}

src_install() {
	elisp-install emacs-cl *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" emacs-cl
	dobin ${FILESDIR}/emacs-cl
	dodoc HACKING HOWTO README BUGS COPYING
}
