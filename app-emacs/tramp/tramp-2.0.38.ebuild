# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tramp/tramp-2.0.38.ebuild,v 1.1 2004/02/17 21:14:24 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="TRAMP is a package for editing remote files similar to ange-ftp but with rlogin, telnet and/or ssh"
HOMEPAGE="http://savannah.nongnu.org/projects/tramp/"
# I cannot find tramp-2.0.38 on master site atm (2004/02/17)
#SRC_URI="http://savannah.nongnu.org/download/tramp/${P}.tar.gz"
SRC_URI="mirror://debian/pool/main/t/tramp/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

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
