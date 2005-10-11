# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-store/cl-store-0.6.ebuild,v 1.1 2005/10/11 15:19:49 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="CL-STORE is a Common Lisp library for serializing and deserializing Common Lisp objects."
HOMEPAGE="http://common-lisp.net/project/cl-store/
	http://www.cliki.net/cl-store"
SRC_URI="http://common-lisp.net/project/cl-store/files/cl-store_${PV}.tgz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="sys-apps/texinfo"

CLPACKAGE=cl-store

S=${WORKDIR}/${PN}_${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-custom.lisp-sbcl.patch	# Fix for SBCL >= 0.9.5
}

src_compile() {
	makeinfo doc/cl-store.texi -o cl-store.info
}

src_install() {
	( shopt -s nullglob; for i in . clisp cmucl ecl lispworks sbcl; do
			insinto $CLSOURCEROOT/$CLPACKAGE/$i
			doins $i/*.{lisp,asd}
		done )
	common-lisp-system-symlink
	dodoc LICENCE README ChangeLog
	doinfo *.info*
}
