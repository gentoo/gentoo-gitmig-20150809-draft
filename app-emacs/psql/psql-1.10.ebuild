# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/psql/psql-1.10.ebuild,v 1.8 2007/01/28 04:27:42 genone Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mode for editing PostgreSQL SQL"
HOMEPAGE="http://www.hgsc.bcm.tmc.edu/~harley/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	dev-db/postgresql"

SITEFILE=50psql-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see ${SITELISP}/${PN}/psql.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
