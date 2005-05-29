# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xml-emitter/cl-xml-emitter-1.0.ebuild,v 1.1 2005/05/29 15:38:41 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp library for XML output with a focus on memory efficiency and convenience."
HOMEPAGE="http://www.cliki.net/xml-emitter"
SRC_URI="mirrors://gentoo/xml-emitter-1.0.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-utilities"

S=${WORKDIR}/${P#cl-}

CLPACKAGE=xml-emitter

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-clisp-gentoo.patch || die
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc README
}
