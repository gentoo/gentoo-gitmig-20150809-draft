# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-binary-types/cl-binary-types-0.84.1.ebuild,v 1.4 2004/07/14 15:22:14 agriffis Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Binary-types is a Library for accessing binary files with fixed bit-length code-words. Binary-types provides macros that are used to declare the mapping between Common Lisp objects and some binary (i.e. octet-based) representation."
HOMEPAGE="http://www.cliki.net/Binary-types http://www.cs.uit.no/~frodef/sw/binary-types/"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-binary-types/cl-binary-types_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-binary-types/cl-binary-types_${PV}-${DEB_PV}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=binary-types


src_unpack() {
	unpack ${A}
	epatch cl-binary-types_${PV}-${DEB_PV}.diff
	epatch ${FILESDIR}/${PV}-gentoo.patch
}

src_install() {
	common-lisp-install ${FILESDIR}/binary-types.asd *.lisp
	common-lisp-system-symlink
	dodoc README-bitfield COPYING ChangeLog type-hierarchy.ps README example.lisp
	do-debian-credits
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
