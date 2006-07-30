# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-smtp/cl-smtp-20060404.1.ebuild,v 1.1 2006/07/30 01:57:43 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp client library for the SMTP network protocol."
HOMEPAGE="http://www.cliki.net/CL-SMTP"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-base64"

CLPACKAGE=cl-smtp

S=${WORKDIR}/${PN}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc CHANGELOG INSTALL *LICENSE README
}
