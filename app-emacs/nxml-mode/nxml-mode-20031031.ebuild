# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-mode/nxml-mode-20031031.ebuild,v 1.1 2004/02/13 19:27:21 mkennedy Exp $

inherit elisp

DESCRIPTION="A new major mode for GNU Emacs for editing XML documents."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/NxmlMode"
SRC_URI="http://thaiopensource.com/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/emacs"

S=${WORKDIR}/${P}

SITEFILE=80nxml-mode-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-info-gentoo.patch
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
