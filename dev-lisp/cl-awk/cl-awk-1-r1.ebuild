# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-awk/cl-awk-1-r1.ebuild,v 1.1 2004/02/12 09:13:13 mkennedy Exp $

inherit common-lisp

DEB_PV=1

DESCRIPTION="Common Lisp implementation of AWK"
HOMEPAGE="http://www.geocities.com/mparker762/clawk.html#clawk
	http://www.cliki.net/RegEx-CLAWK-Lexer
	http://packages.debian.org/unstable/devel/cl-awk.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-awk/cl-awk_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-awk/cl-awk_1-${DEB_PV}.diff.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/cl-regex"

CLPACKAGE=clawk

S=${WORKDIR}/cl-awk-${PV}

src_unpack() {
	unpack ${A}
	epatch cl-awk_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install clawk.lisp utils.lisp packages.lisp clawk.asd
	common-lisp-system-symlink
	do-debian-credits
	dodoc license.txt
	docinto examples
	dodoc clawktest.lisp emp.data
}
