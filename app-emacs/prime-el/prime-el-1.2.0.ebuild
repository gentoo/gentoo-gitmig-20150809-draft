# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/prime-el/prime-el-1.2.0.ebuild,v 1.2 2003/12/24 22:57:55 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="PRIME Client for Emacs"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${P}"

DEPEND="app-emacs/apel
	app-emacs/mell
	dev-libs/suikyo"

src_unpack() {

	unpack ${A}

	cd ${S}
	sed -i -e "s: debian/emacsen-startup::" configure.ac

}

src_compile() {

	autoconf || die
	econf --with-prime-initdir=/usr/share/emacs/site-lisp \
			--with-prime-docdir=usr/share/doc/${PF} \
			|| die
	emake || die

}

src_install() {

	einstall DESTDIR=${D} || die
	make DESTDIR=${D} install-etc || die

	elisp-site-file-install ${FILESDIR}/50prime-el-gentoo.el

	dodoc [A-Z][A-Z]* ChangeLog

	mv ${D}/usr/share/doc/${PF}/{emacs,html}

}
