# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-2.3.ebuild,v 1.1 2003/08/05 09:45:13 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="ftp://ftp.mew.org/pub/Mew/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc"
S="${WORKDIR}/${P}"

DEPEND="virtual/emacs"

SITEFILE=50mew-gentoo.el

src_compile() {

	make || die
}

src_install() {

	einstall elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN} || die

 	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	dodoc 00*
}

pkg_postinst() {

	elisp-site-regen

	einfo ""
	einfo "Refer to the Info documentation on Mew for how to get started."
	einfo ""
}

pkg_postrm() {

	elisp-site-regen
}
