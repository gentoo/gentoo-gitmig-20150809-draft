# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-zebu/cl-zebu-3.5.5.ebuild,v 1.1 2004/11/08 02:55:44 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Zebu is a Library for LALR(1) parser generation."
HOMEPAGE="http://www.cliki.net/Zebu"
SRC_URI="http://constantly.at/lisp/zebu-${PV}-asdf.tgz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/cl-ppcre"

CLPACKAGE='zebu zebu-rr zebu-compiler'

S=${WORKDIR}/zebu-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-zebu-compiler-gentoo.patch
	rm ${S}/{zebu-mg.tab,zmg-dom.lisp}
}

src_install() {
	dodir ${CLSYSTEMROOT}
	for system in ${CLPACKAGE}; do
		insinto ${CLSOURCEROOT}/${system}/
		doins *.{lisp,zb} ${system}.asd
		dosym ${CLSOURCEROOT}/${system}/${system}.asd ${CLSYSTEMROOT}/
	done
	dohtml examples.html
	dodoc COPYRIGHT ChangeLog README* doc/Zebu_intro.ps
}

# TODO: (see zebu-loader.lisp)
#
# Build error: error opening #P"/usr/share/common-lisp/source/zebu-compiler/zmg-dom.lisp":
#				 Permission denied
# Build failure
