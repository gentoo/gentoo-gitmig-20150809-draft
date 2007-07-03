# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sumibi/sumibi-0.5.2.ebuild,v 1.2 2007/07/03 09:19:46 opfer Exp $

inherit elisp

DESCRIPTION="Statistical Japanese input method using the Internet as a large corpus"
HOMEPAGE="http://www.sumibi.org/"
SRC_URI="mirror://sourceforge.jp/sumibi/17176/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
DEPEND=""
IUSE=""
SITEFILE=50${PN}-gentoo.el
DOCS="README CREDITS CHANGELOG"

src_compile() {
	cd client/elisp
	elisp-comp *.el || die "elisp-comp failed"
	mv *.el* ..
}
