# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/prime-el/prime-el-1.3.1_rc1.ebuild,v 1.1 2004/01/27 11:48:20 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="PRIME Client for Emacs"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P/_/-}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
S="${WORKDIR}/${P/_/-}"

DEPEND="app-emacs/apel
	app-emacs/mell
	dev-libs/suikyo"
RDEPEND="${DEPEND}
	app-i18n/prime"

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

	make DESTDIR=${D} install || die
	make DESTDIR=${D} install-etc || die

	elisp-site-file-install ${FILESDIR}/50prime-el-gentoo.el

	dodoc [A-Z][A-Z]* ChangeLog

	mv ${D}/usr/share/doc/${PF}/{emacs,html}

}
