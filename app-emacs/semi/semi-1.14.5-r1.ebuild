# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/semi/semi-1.14.5-r1.ebuild,v 1.4 2003/08/13 07:28:06 usata Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="a library to provide MIME feature for GNU Emacs -- SEMI"
HOMEPAGE="http://cvs.m17n.org/elisp/SEMI/index.html.ja.iso-2022-jp"
SRC_URI="ftp://ftp.m17n.org/pub/mule/semi/semi-1.14-for-flim-1.14/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha sparc ppc"

DEPEND="virtual/emacs
	>=app-emacs/apel-10.6
	virtual/flim"

PROVIDE="virtual/semi"
S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	make PREFIX=${D}/usr \
		LISPDIR=${D}/${SITELISP} \
		VERSION_SPECIFIC_LISPDIR=${D}/${SITELISP} || die
}

src_install() {
	make PREFIX=${D}/usr \
		LISPDIR=${D}/${SITELISP} \
		VERSION_SPECIFIC_LISPDIR=${D}/${SITELISP} install || die

 	elisp-site-file-install ${FILESDIR}/65semi-gentoo.el

	dodoc README* ChangeLog VERSION NEWS
}

pkg_postinst() {
	elisp-site-regen

	einfo "Please unmerge another versions or variants, if installed."
	einfo "You need to rebuild packages depending on ${PN}."
}

pkg_postrm() {
	elisp-site-regen
}
