# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/http-emacs/http-emacs-1.1.ebuild,v 1.4 2004/11/01 10:56:30 usata Exp $

inherit elisp

DESCRIPTION="http-emacs includes http-post and http-get which allows you to fetch, render and post html pages via emacs."
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?SimpleWikiEditMode"
SRC_URI="http://savannah.nongnu.org/download/http-emacs/http-emacs.pkg/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc-macos"
IUSE=""
S=${WORKDIR}/${PN}

SITEFILE=50http-emacs-gentoo.el

src_compile() {
	elisp-comp http-*.el || die
}

src_install() {
	elisp-install ${PN} http-*.el*
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc CONTRIBUTORS
}
