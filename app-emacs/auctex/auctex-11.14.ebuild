# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/auctex/auctex-11.14.ebuild,v 1.2 2003/05/15 13:41:29 phosphan Exp $

inherit elisp 

IUSE=""

DESCRIPTION="AUC TeX is an extensible package that supports writing and formatting TeX files"
HOMEPAGE="http://www.gnu.org/software/auctex"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/emacs
	app-text/tetex"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	sed -i 's,/usr/local/lib/texmf/tex/,/usr/share/texmf/tex/,g' ${S}/tex.el || die
}

src_compile() {
	make || die
}

src_install() {
	dodir ${SITELISP}/auctex
	make lispdir=${D}/${SITELISP} install install-contrib || die
	sed -i "s,${D}/,,g" ${D}/${SITELISP}/tex-site.el || die
	pushd doc
	dodir /usr/share/info
	make infodir=${D}/usr/share/info install || die
	for i in ${D}/usr/share/info/* ; do mv $i $i.info ; done
	popd
 	elisp-site-file-install ${FILESDIR}/50auctex-gentoo.el
 	dodoc ChangeLog CHANGES COPYING INSTALLATION PROBLEMS README 
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
