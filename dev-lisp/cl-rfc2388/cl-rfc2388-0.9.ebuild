# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rfc2388/cl-rfc2388-0.9.ebuild,v 1.1 2005/04/06 06:36:20 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="An implementation of RFC 2388 in Common Lisp"
HOMEPAGE="http://common-lisp.net/project/rfc2388/"
SRC_URI="ftp://common-lisp.net/pub/project/rfc2388/rfc2388_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/rfc2388

CLPACKAGE=rfc2388

src_install() {
	common-lisp-install *.lisp rfc2388.asd
	common-lisp-system-symlink
}
