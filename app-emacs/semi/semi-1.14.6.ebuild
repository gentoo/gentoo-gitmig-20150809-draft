# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/semi/semi-1.14.6.ebuild,v 1.9 2004/10/23 07:48:26 mr_bones_ Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="a library to provide MIME feature for GNU Emacs -- SEMI"
HOMEPAGE="http://cvs.m17n.org/elisp/SEMI/"
SRC_URI="ftp://ftp.m17n.org/pub/mule/semi/semi-1.14-for-flim-1.14/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha sparc ppc ppc-macos"

DEPEND="virtual/emacs
	>=app-emacs/apel-10.6
	virtual/flim
	!virtual/semi"

PROVIDE="virtual/semi"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-info.patch
}

src_compile() {
	make PREFIX=${D}/usr \
		LISPDIR=${D}/${SITELISP} \
		VERSION_SPECIFIC_LISPDIR=${D}/${SITELISP} || die

	emacs -batch -q --no-site-file -l ${FILESDIR}/comp.el \
		|| die "compile info failed"
}

src_install() {
	make PREFIX=${D}/usr \
		LISPDIR=${D}/${SITELISP} \
		VERSION_SPECIFIC_LISPDIR=${D}/${SITELISP} install || die

	elisp-site-file-install ${FILESDIR}/65semi-gentoo.el

	dodoc README* ChangeLog VERSION NEWS
	doinfo *.info
}
