# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-bouquet/cl-bouquet-0.1.ebuild,v 1.3 2004/05/28 15:40:59 vapier Exp $

inherit common-lisp eutils

DESCRIPTION="BOUQUET is a graph generator for ANSI Common Lisp which produces Tulip graph description files."
HOMEPAGE="http://sourceforge.net/projects/bouquet/"
SRC_URI="mirror://sourceforge/bouquet/bouquet-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

CLPACKAGE=bouquet

S=${WORKDIR}/bouquet

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-clisp-package-lock-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README LICENSE
}
