# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-diff/cl-diff-0.3.ebuild,v 1.2 2005/03/22 15:29:46 mkennedy Exp $

inherit common-lisp

DESCRIPTION="DIFF is a Common Lisp library for computing the unified or context difference between two files."
HOMEPAGE="http://www.cliki.net/DIFF"
SRC_URI="http://www.cs.rice.edu/~froydnj/lisp/diff-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=diff

S=${WORKDIR}/diff

src_install() {
	common-lisp-install *.asd *.lisp README TODO NEWS LICENSE
	common-lisp-system-symlink
	dodoc README TODO NEWS LICENSE
	docinto test-files
	dodoc test-files/*
}
