# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuplot-mode/gnuplot-mode-0.6.0.ebuild,v 1.4 2004/10/17 05:42:24 usata Exp $

inherit elisp

IUSE=""

MY_P=${PN}.${PV}
DESCRIPTION="Gnuplot mode for Emacs"
HOMEPAGE="http://feff.phys.washington.edu/~ravel/gnuplot/"
SRC_URI="http://feff.phys.washington.edu/~ravel/gnuplot/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	media-gfx/gnuplot"

S="${WORKDIR}/${MY_P}"

SITEFILE=50gnuplot-gentoo.el

src_compile() {
	econf || die
	emake || die
}

src_install() {

	PATH=./:$PATH make install lispdir=$D/usr/share/emacs/site-lisp/${PN} || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	dodoc ChangeLog README
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/${PN}.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
