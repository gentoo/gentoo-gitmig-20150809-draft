# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-smtp/cl-smtp-20100505.1.ebuild,v 1.1 2010/06/01 19:46:21 zmedico Exp $

EAPI=3
inherit common-lisp

DESCRIPTION="A Common Lisp client library for the SMTP network protocol."
HOMEPAGE="http://www.cliki.net/CL-SMTP"
SRC_URI="http://common-lisp.net/project/cl-smtp/cl-smtp.tar.gz -> ${P}.tar.gz"
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
