# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/simple-wiki/simple-wiki-1.1.ebuild,v 1.7 2007/07/03 09:44:22 opfer Exp $

inherit elisp

DESCRIPTION="An Emacs mode for editing Wiki pages."
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?SimpleWikiEditMode"
SRC_URI="http://savannah.nongnu.org/download/http-emacs/http-emacs.pkg/${PV}/http-emacs-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="=app-emacs/http-emacs-${PV}"

S=${WORKDIR}/http-emacs

SITEFILE=60simple-wiki-gentoo.el
DOCS="CONTRIBUTORS"

src_compile() {
	elisp-comp simple-*.el || die "elisp-comp failed"
}
