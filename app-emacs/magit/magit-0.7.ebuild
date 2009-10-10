# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/magit/magit-0.7.ebuild,v 1.1 2009/10/10 10:50:11 ulm Exp $

inherit elisp

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://zagadka.vm.bytemark.co.uk/magit/"
SRC_URI="http://zagadka.vm.bytemark.co.uk/magit/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50magit-gentoo.el"

src_install() {
	elisp-install ${PN} magit.{el,elc} || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo magit.info || die "doinfo failed"
	dodoc AUTHORS NEWS README
}
