# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-binary-types/cl-binary-types-0.84.ebuild,v 1.1 2003/09/01 19:41:35 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Binary-types is a Library for accessing binary files with fixed bit-length code-words. Binary-types provides macros that are used to declare the mapping between Common Lisp objects and some binary (i.e. octet-based) representation."
HOMEPAGE="http://www.cliki.net/Binary-types
	http://www.cs.uit.no/~frodef/sw/binary-types/"
SRC_URI="http://www.cs.uit.no/~frodef/sw/binary-types/binary-types-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=binary-types

S=${WORKDIR}/${P/cl-/}

src_install() {
	common-lisp-install ${FILESDIR}/binary-types.asd *.lisp
	common-lisp-system-symlink
	dodoc README-bitfield COPYING ChangeLog type-hierarchy.ps README example.lisp
}
