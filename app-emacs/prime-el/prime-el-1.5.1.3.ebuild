# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/prime-el/prime-el-1.5.1.3.ebuild,v 1.7 2007/10/07 18:50:35 ulm Exp $

inherit elisp

MY_P="${P/_p/.}"

DESCRIPTION="PRIME Client for Emacs"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ppc64 x86"
IUSE=""

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
	make DESTDIR="${D}" install || die
	make DESTDIR="${D}" install-etc || die

	elisp-site-file-install "${FILESDIR}"/50prime-el-gentoo.el

	dodoc [A-Z][A-Z]* ChangeLog

	mv "${D}"/usr/share/doc/${PF}/{emacs,html}
}
