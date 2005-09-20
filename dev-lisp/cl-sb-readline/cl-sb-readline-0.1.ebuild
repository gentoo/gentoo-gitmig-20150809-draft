# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sb-readline/cl-sb-readline-0.1.ebuild,v 1.2 2005/09/20 15:39:35 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Implementation of GNU Readline support for SBCL"
HOMEPAGE="http://www.cliki.net/sb-readline"
SRC_URI="http://www.caddr.com/lisp/sb-readline/sb-readline-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lisp/sbcl-0.9.3
	sys-libs/readline"

CLPACKAGE=sb-readline

S=${WORKDIR}/sb-readline-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-load-foreign-library-gentoo.patch
}

src_install() {
	common-lisp-install sb-readline.{lisp,asd}
	common-lisp-system-symlink
	dodoc COPYING
	dohtml README.html
}
