# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/simple-wiki/simple-wiki-1.1.ebuild,v 1.6 2005/10/24 15:04:30 josejx Exp $

inherit elisp

DESCRIPTION="An Emacs mode for editing Wiki pages."
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?SimpleWikiEditMode"
SRC_URI="http://savannah.nongnu.org/download/http-emacs/http-emacs.pkg/${PV}/http-emacs-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="virtual/emacs
	=app-emacs/http-emacs-${PV}"

S=${WORKDIR}/http-emacs

SITEFILE=60simple-wiki-gentoo.el

src_compile() {
	elisp-comp simple-*.el || die
}

src_install() {
	elisp-install ${PN} simple-*.el*
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc CONTRIBUTORS
}
