# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xslide/xslide-0.2.2.ebuild,v 1.8 2007/07/03 07:00:24 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="An Emacs major mode for editing XSL stylesheets and running XSL processes."
HOMEPAGE="http://www.menteith.com/xslide/"
SRC_URI="mirror://sourceforge/xslide/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~ppc-macos x86"

DEPEND="app-arch/unzip"

SITEFILE=50xslide-gentoo.el
DOC="CHANGELOG.TXT README.TXT"

src_compile() {
	emake EMACS=emacs || die "emake failed"
}
