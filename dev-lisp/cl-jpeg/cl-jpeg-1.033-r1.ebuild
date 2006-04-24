# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-jpeg/cl-jpeg-1.033-r1.ebuild,v 1.9 2006/04/24 21:40:59 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="A JPEG library for Common Lisp"
HOMEPAGE="http://sourceforge.net/projects/cljl"
SRC_URI="mirror://sourceforge/cljl/cljl-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-plus"

CLPACKAGE=cl-jpeg

S=${WORKDIR}/cljl

src_unpack() {
	unpack ${A}
	# patch: defconstant - compilation fix for SBCL
	# patch: exports - export symbols at load time as well
	# patch: quantize-optimization-clisp - dont bother on CLISP
	epatch ${FILESDIR}/${PV}-defconstant-gentoo.patch
	epatch ${FILESDIR}/${PV}-exports-gentoo.patch
	epatch ${FILESDIR}/${PV}-quantize-optimization-clisp-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc LICENSE
}
