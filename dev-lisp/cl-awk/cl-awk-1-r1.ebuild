# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-awk/cl-awk-1-r1.ebuild,v 1.4 2005/03/18 07:36:16 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp implementation of AWK"
HOMEPAGE="http://www.geocities.com/mparker762/clawk.html#clawk http://www.cliki.net/RegEx-CLAWK-Lexer http://packages.debian.org/unstable/devel/cl-awk.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-awk/cl-awk_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-awk/cl-awk_1-${DEB_PV}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lisp/cl-regex"

S=${WORKDIR}/cl-awk-${PV}

CLPACKAGE=clawk

src_unpack() {
	unpack ${A}
	epatch cl-awk_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install clawk.lisp utils.lisp packages.lisp clawk.asd
	common-lisp-system-symlink
	do-debian-credits
	docinto examples
	dodoc clawktest.lisp emp.data
}
