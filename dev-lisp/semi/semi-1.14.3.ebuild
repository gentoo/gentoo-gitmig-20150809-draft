# Copyright 2002 moto kawasaki <kawasaki@kawasaki3.org>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/semi/semi-1.14.3.ebuild,v 1.4 2002/09/21 00:41:29 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a library to provide MIME feature for GNU Emacs -- SEMI"
SRC_URI="ftp://ftp.m17n.org/pub/mule/semi/semi-1.14-for-flim-1.14/${P}.tar.gz"
HOMEPAGE="http://cvs.m17n.org/elisp/SEMI/index.html.ja.iso-2022-jp"
DEPEND=">=app-editors/emacs-20.4
		>=dev-lisp/apel-9.22
		>=dev-lisp/flim-1.14.2"
RDEPEND="${depend}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_install() {
	make PREFIX=${D}/usr install || die

	dodoc ChangeLog NEWS README* SEMI* TODO VERSION
}
