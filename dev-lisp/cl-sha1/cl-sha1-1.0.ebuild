# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sha1/cl-sha1-1.0.ebuild,v 1.3 2004/04/21 17:22:01 vapier Exp $

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

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc README
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
