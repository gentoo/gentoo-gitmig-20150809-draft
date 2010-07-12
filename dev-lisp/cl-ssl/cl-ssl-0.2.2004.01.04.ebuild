# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ssl/cl-ssl-0.2.2004.01.04.ebuild,v 1.9 2010/07/12 23:37:30 ssuominen Exp $

inherit common-lisp eutils multilib toolchain-funcs

DEB_PV=

DESCRIPTION="Common Lisp UFFI interface of the OpenSSL library."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-ssl"
SRC_URI="mirror://gentoo/cl-ssl_${PV/.2004/+cvs.2004}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
DEPEND="dev-libs/openssl
	dev-lisp/cl-uffi"

CLPACKAGE=cl-ssl

S=${WORKDIR}/${PN}-${PV/.2004/+cvs.2004}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	tc-export CC
	emake -C cl-ssl linux || die
}

src_install() {
	common-lisp-install cl-ssl/*.asd cl-ssl/*.lisp
	common-lisp-system-symlink
	dodoc COPYING README preamble.html
	exeinto /usr/$(get_libdir)/cl-ssl
	doexe cl-ssl/ssl.so || die
	do-debian-credits
}
