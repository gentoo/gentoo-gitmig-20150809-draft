# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/magit/magit-0.8.2.ebuild,v 1.1 2010/07/18 06:25:52 fauli Exp $

inherit elisp

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://philjackson.github.com/magit/"
SRC_URI="http://github.com/downloads/philjackson/magit/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50magit-gentoo.el"

src_install() {
	elisp-install ${PN} magit.{el,elc} || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo magit.info || die
	dodoc AUTHORS NEWS README
}
