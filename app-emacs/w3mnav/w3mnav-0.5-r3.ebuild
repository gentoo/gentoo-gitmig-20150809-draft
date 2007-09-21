# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/w3mnav/w3mnav-0.5-r3.ebuild,v 1.1 2007/09/21 09:15:45 ulm Exp $

inherit elisp

DESCRIPTION="Add Info-like navigation keys to the emacs-w3m web browser"
HOMEPAGE="http://www.neilvandyke.org/w3mnav/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-emacs/emacs-w3m"

SITEFILE=75${PN}-gentoo.el

src_compile() {
	emacs -batch -q --no-site-file -L "${SITELISP}/emacs-w3m" \
		-f batch-byte-compile w3mnav.el || die "byte-compile failed"
}
