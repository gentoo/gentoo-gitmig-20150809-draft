# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/prime-el/prime-el-1.5.1.3.ebuild,v 1.1 2005/04/03 15:14:38 nigoro Exp $

inherit elisp

IUSE=""

MY_P="${P/_p/.}"

DESCRIPTION="PRIME Client for Emacs"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc ~ppc64"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="app-emacs/apel
	app-emacs/mell
	dev-libs/suikyo"
RDEPEND="${DEPEND}
	>=app-i18n/prime-0.8.6"

src_compile() {

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
