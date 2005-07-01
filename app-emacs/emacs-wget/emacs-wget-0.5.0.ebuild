# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-wget/emacs-wget-0.5.0.ebuild,v 1.3 2005/07/01 18:14:57 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Wget interface for Emacs"
HOMEPAGE="http://pop-club.hp.infoseek.co.jp/emacs/emacs-wget/"
SRC_URI="http://pop-club.hp.infoseek.co.jp/emacs/emacs-wget/${P}.tar.gz"

RDEPEND=">=net-misc/wget-1.8.2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~ppc64 ~x86"

src_compile(){

	elisp-comp *.el || die
}

src_install(){

	elisp-install ${PN} *.el{,c} || die
	elisp-site-file-install ${FILESDIR}/65emacs-wget-gentoo.el || die

	dodoc ChangeLog README* USAGE*
}
