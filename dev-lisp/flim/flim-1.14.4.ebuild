# Copyright 2002 moto kawasaki <kawasaki@kawasaki3.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/flim/flim-1.14.4.ebuild,v 1.6 2002/10/20 18:42:33 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A library to provide basic features about message representation or encoding -- FLIM"
SRC_URI="ftp://ftp.m17n.org/pub/mule/flim/flim-1.14/${P}.tar.gz"
HOMEPAGE="http://www.m17n.org/flim/"
DEPEND=">=app-editors/emacs-20.4
        >=dev-lisp/apel-9.22"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	cd ${S};

	make || die
}

src_install() {
	make PREFIX=${D}/usr install || die

	dodoc FLIM* NEWS VERSION README* Changelog
}
