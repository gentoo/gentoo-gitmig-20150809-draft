# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/semi/semi-1.14.6_pre20031218.ebuild,v 1.1 2003/12/20 02:53:21 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="a library to provide MIME feature for GNU Emacs -- SEMI"
HOMEPAGE="http://cvs.m17n.org/elisp/SEMI/index.html.ja.iso-2022-jp"
SRC_URI="http://dev.gentoo.org/~usata/distfiles/${P/_pre/.}.tar.gz
	ftp://ftp.m17n.org/pub/mule/semi/semi-1.14-for-flim-1.14/${P/_pre/.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc"

DEPEND="virtual/emacs
	>=app-emacs/apel-10.6
	virtual/flim
	!virtual/semi"

PROVIDE="virtual/semi"
S="${WORKDIR}/${P%%-*_pre*}"

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
