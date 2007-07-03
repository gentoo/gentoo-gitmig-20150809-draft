# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-wget/emacs-wget-0.5.0.ebuild,v 1.4 2007/07/03 07:17:25 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="Wget interface for Emacs"
HOMEPAGE="http://pop-club.hp.infoseek.co.jp/emacs/emacs-wget/"
SRC_URI="http://pop-club.hp.infoseek.co.jp/emacs/emacs-wget/${P}.tar.gz"

RDEPEND=">=net-misc/wget-1.8.2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~ppc64 ~x86"
SITEFILE=65${PN}-gentoo.el
DOCS="ChangeLog README* USAGE*"

src_compile(){
	elisp-comp *.el || die "elisp-comp failed"
}
