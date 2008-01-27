# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/emacs-cl-cvs/emacs-cl-cvs-0.ebuild,v 1.3 2008/01/27 19:10:28 ulm Exp $

ECVS_SERVER="cvs.nocrew.org:/usr/local/cvsroot"
ECVS_MODULE="emacs-cl"

inherit elisp cvs

DESCRIPTION="An implementation of Common Lisp written in Emacs Lisp"
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
	emake EMACS="${EMACS}" || die "emake failed"
}

src_test() {
	emake -j1 check EMACSEN="${EMACS}" || die "emake check failed"
}

src_install() {
	elisp-install emacs-cl *.{el,elc} || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" emacs-cl \
		|| die "elisp-site-file-install failed"
	dobin "${FILESDIR}/emacs-cl"
	dodoc BUGS HACKING HOWTO README
}
