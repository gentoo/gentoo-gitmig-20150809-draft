# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cdi/cdi-1.45.ebuild,v 1.7 2005/01/01 13:40:18 eradicator Exp $

inherit elisp

IUSE=""

DESCRIPTION="Interface between Emacs and command-line CD players"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?action=browse&id=MattHodges&oldid=MatthewHodges"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	media-sound/cdcd"

SITEFILE=50cdi-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/cdi.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
