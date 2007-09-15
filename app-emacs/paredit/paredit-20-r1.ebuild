# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/paredit/paredit-20-r1.ebuild,v 1.1 2007/09/15 23:55:17 ulm Exp $

inherit elisp

DESCRIPTION="Minor mode for performing structured editing of S-expressions"
HOMEPAGE="http://mumble.net/~campbell/emacs/
	http://www.emacswiki.org/cgi-bin/wiki/ParEdit"
SRC_URI="http://mumble.net/~campbell/emacs/${P}.el
	http://mumble.net/~campbell/emacs/${P}.html"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}.el" ${PN}.el || die "cp ${P}.el failed"
	cp "${DISTDIR}/${P}.html" ${PN}.html || die "cp ${P}.html failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dohtml *.html
}
