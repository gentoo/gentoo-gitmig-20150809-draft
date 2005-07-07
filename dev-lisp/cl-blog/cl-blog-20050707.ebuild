# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-blog/cl-blog-20050707.ebuild,v 1.1 2005/07/07 16:45:34 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="CL-BLOG is blog engine for Common Lisp"
HOMEPAGE="http://www.cliki.net/cl-blog"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-split-sequence
	dev-lisp/cl-araneida
	dev-lisp/cl-net-telent-date
	dev-lisp/cl-md5
	dev-lisp/cl-html-encode
	dev-lisp/cl-ppcre
	dev-lisp/cl-trivial-http
	dev-lisp/cl-trivial-configuration-parser"

S=${WORKDIR}/${PN}

CLPACKAGE=cl-blog

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_install() {
	common-lisp-install *.asd
	insinto $CLSOURCEROOT/$CLPACKAGE/source
	doins source/*
	common-lisp-system-symlink
	dodoc README ${FILESDIR}/README.Gentoo
	insinto /etc/cl-blog
	doins *.{conf,template}
	keepdir /var/lib/cl-blog/entries/
}

