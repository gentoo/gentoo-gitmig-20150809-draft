# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-3.1.ebuild,v 1.1 2002/12/13 08:13:42 nakano Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mew is a great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="ftp://ftp.mew.org/pub/Mew/release/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

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
	einfo ""
	einfo 'If you use mew-2.* until now, you should rewrite ${HOME}/.mew.el'
	einfo ""
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
