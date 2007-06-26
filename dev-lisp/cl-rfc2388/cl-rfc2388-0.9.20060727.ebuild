# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rfc2388/cl-rfc2388-0.9.20060727.ebuild,v 1.2 2007/06/26 01:55:32 mr_bones_ Exp $

inherit common-lisp eutils

DESCRIPTION="An implementation of RFC 2388 in Common Lisp"
HOMEPAGE="http://common-lisp.net/project/rfc2388/"
SRC_URI="ftp://common-lisp.net/pub/project/rfc2388/rfc2388_0.9.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/rfc2388

CLPACKAGE=rfc2388

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/20060727-sbcl-external-format.patch
}

src_install() {
	common-lisp-install *.lisp rfc2388.asd
	common-lisp-system-symlink
}
