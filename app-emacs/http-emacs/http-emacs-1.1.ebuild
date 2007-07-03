# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/http-emacs/http-emacs-1.1.ebuild,v 1.9 2007/07/03 09:24:30 opfer Exp $

inherit elisp

DESCRIPTION="Allows you to fetch, render and post html pages via Emacs"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?SimpleWikiEditMode"
SRC_URI="http://savannah.nongnu.org/download/http-emacs/http-emacs.pkg/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc ~ppc-macos x86"
IUSE=""
S=${WORKDIR}/${PN}
DOCS="CONTRIBUTORS"

SITEFILE=50http-emacs-gentoo.el

src_compile() {
	elisp-comp http-*.el || die "elisp-comp failed"
}
