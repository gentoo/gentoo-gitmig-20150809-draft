# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-2.2.ebuild,v 1.5 2003/05/29 11:39:27 yakina Exp $

inherit elisp

DESCRIPTION="great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="ftp://ftp.mew.org/pub/Mew/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
S="${WORKDIR}/${P}"

DEPEND="virtual/emacs"

SITEFILE=50mew-gentoo.el

src_compile() {
	make || die
}

src_install() {
	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN}  install || die

 	elisp-install ${PN} *.el *.elc || die
 	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	dodoc 00*
	einfo "Refer to the Info documentation on Mew for how to get started."
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
