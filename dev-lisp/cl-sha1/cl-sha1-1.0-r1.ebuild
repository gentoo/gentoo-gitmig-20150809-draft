# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sha1/cl-sha1-1.0-r1.ebuild,v 1.4 2005/02/03 05:39:01 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp package for SHA1 Message Digests"
HOMEPAGE="http://www.cs.rice.edu/~froydnj/lisp/ http://www.cliki.net/sb-sha1"
SRC_URI="mirror://gentoo/sb-sha1-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=sb-sha1

S=${WORKDIR}/sb-sha1

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/cl-sha1-gentoo.patch
}

src_compile() {
	:
}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc README
}
