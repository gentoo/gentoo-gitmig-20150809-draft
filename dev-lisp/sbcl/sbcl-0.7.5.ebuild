# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.7.5.ebuild,v 1.9 2003/09/06 22:35:54 msterret Exp $

DESCRIPTION="Steel Bank Common Lisp"
HOMEPAGE="http://sbcl.sourceforge.net/"
BOOTSTRAPPER="0.7.2"
BIN=${PN}-${BOOTSTRAPPER}
SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	mirror://sourceforge/sbcl/${BIN}-x86-linux-binary.tar.bz2
	mirror://sourceforge/sbcl/${P}-html.tar.bz2"

LICENSE="MIT"
SLOT="0"
# 2002.07.19 -- karltk:
# Requires x86-only binary for bootstrapping
# Krystof promises ppc binary for 0.7.6
# Sparc is a lost cause.
KEYWORDS="x86 -ppc -sparc "
PROVIDE="virtual/commonlisp"
DEPEND=""

src_unpack() {
	unpack ${BIN}-x86-linux-binary.tar.bz2
	mv ${BIN} ${BIN}-binary

	unpack ${P}-source.tar.bz2
	unpack ${P}-html.tar.bz2
}

src_compile() {
	export SBCL_HOME="../${BIN}-binary/output/"
	# 2002.07.19 -- karltk:
	# Marius tells me parallell make is  2-3 years off.
	export GNUMAKE="make"
	sh make.sh "../${BIN}-binary/src/runtime/sbcl" || die
}

src_install() {
	doman doc/sbcl.1
	dobin src/runtime/sbcl

	dodoc BUGS CREDITS NEWS README INSTALL COPYING
	dohtml doc/html/*

	LIB=${DESTTREE}/lib/sbcl

	dodir ${LIB}
	insinto ${LIB}
	doins output/sbcl.core

	dodir /etc/env.d

	echo "SBCL_HOME=${LIB}" > ${D}/etc/env.d/10sbcl
}
