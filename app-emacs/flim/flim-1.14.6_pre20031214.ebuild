# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/flim/flim-1.14.6_pre20031214.ebuild,v 1.1 2003/12/20 02:14:09 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="A library to provide basic features about message representation or encoding -- FLIM"
HOMEPAGE="http://cvs.m17n.org/elisp/FLIM/"
SRC_URI="http://dev.gentoo.org/~usata/distfiles/${P/_pre/.}.tar.gz
	ftp://ftp.m17n.org/pub/mule/flim/flim-1.14/${P/_pre/.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc"

DEPEND="virtual/emacs
	!virtual/flim
	>=app-emacs/apel-10.3"

PROVIDE="virtual/flim"
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

	elisp-site-file-install ${FILESDIR}/60flim-gentoo.el

	dodoc FLIM-API.en NEWS VERSION README* Changelog
}

pkg_postinst() {
	elisp-site-regen

	einfo "Please unmerge another version or variatns, if you installed."
	einfo "And you need to rebuild packages depending on ${PN}."
}

pkg_postrm() {
	elisp-site-regen
}
