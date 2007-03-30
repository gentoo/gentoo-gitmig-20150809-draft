# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-mode/nxml-mode-20040910.ebuild,v 1.6 2007/03/30 19:11:34 grobian Exp $

inherit elisp eutils

DESCRIPTION="A new major mode for GNU Emacs for editing XML documents."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/NxmlMode"
SRC_URI="http://thaiopensource.com/download/${P}.tar.gz
	mirror://gentoo/${P}-xmlschema.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

SITEFILE=80nxml-mode-gentoo.el

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${PN}-info-gentoo.patch
	epatch ${DISTDIR}/${P}-xmlschema.patch.gz
}

src_compile() {
	emacs -batch -l rng-auto.el -f rng-byte-compile-load
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	cp -r ${S}/schema ${D}/${SITELISP}/${PN}
	cp -r ${S}/char-name ${D}/${SITELISP}/${PN}
	dodoc README VERSION TODO NEWS
	makeinfo --force nxml-mode.texi
	doinfo nxml-mode.info
}
