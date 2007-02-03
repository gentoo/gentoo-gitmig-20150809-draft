# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ssl/cl-ssl-0.2.2004.01.04.ebuild,v 1.7 2007/02/03 17:49:16 flameeyes Exp $

inherit common-lisp

DEB_PV=

DESCRIPTION="Common Lisp UFFI interface of the OpenSSL library."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-ssl.html"
SRC_URI="mirror://gentoo/cl-ssl_${PV/.2004/+cvs.2004}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""
DEPEND="dev-libs/openssl
	dev-lisp/cl-uffi"

CLPACKAGE=cl-ssl

S=${WORKDIR}/${PN}-${PV/.2004/+cvs.2004}

src_compile() {
	make -C cl-ssl linux || die
}

src_install() {
	common-lisp-install cl-ssl/*.asd cl-ssl/*.lisp
	common-lisp-system-symlink
	dodoc COPYING README preamble.html
	exeinto /usr/lib/cl-ssl
	doexe cl-ssl/ssl.so
	do-debian-credits
}
