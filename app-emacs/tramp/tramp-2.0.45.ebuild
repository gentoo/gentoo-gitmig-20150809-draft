# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tramp/tramp-2.0.45.ebuild,v 1.1 2004/11/04 15:58:57 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="TRAMP is a package for editing remote files similar to ange-ftp but with rlogin, telnet and/or ssh"
HOMEPAGE="http://savannah.nongnu.org/projects/tramp/"
SRC_URI="http://savannah.nongnu.org/download/tramp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~ppc"

src_compile() {

	econf || die "econf failed"
	emake || die "compile problem"
}

src_install() {

	dodir /usr/share/info
	dodir /usr/share/emacs/etc
	dodir /usr/share/emacs/site-lisp/tramp

	einstall lispdir=${D}/usr/share/emacs/site-lisp/tramp || die

	mv ${D}/usr/share/info/tramp ${D}/usr/share/info/tramp-info

	dohtml texi/*.html
	if [ -f texi/tramp.dvi ] ; then
		insinto /usr/share/doc/${PF}
		doins texi/tramp.dvi
	fi

	elisp-site-file-install ${FILESDIR}/50tramp-gentoo.el

	dodoc README ChangeLog CONTRIBUTORS
}
