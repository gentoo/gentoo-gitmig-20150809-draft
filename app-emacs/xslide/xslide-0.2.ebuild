# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xslide/xslide-0.2.ebuild,v 1.6 2004/11/03 04:49:01 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="xslide is an Emacs major mode for editing XSL stylesheets and running XSL processes."
HOMEPAGE="http://www.menteith.com/xslide/"
SRC_URI="mirror://sourceforge/xslide/${PN}${PV/./}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/"

SITEFILE=50xslide-gentoo.el

src_compile() {
	make EMACS=emacs || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc CHANGELOG.TXT README.TXT
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
