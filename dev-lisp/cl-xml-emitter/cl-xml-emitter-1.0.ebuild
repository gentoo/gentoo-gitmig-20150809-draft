# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xml-emitter/cl-xml-emitter-1.0.ebuild,v 1.2 2005/08/31 17:52:41 swegener Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp library for XML output with a focus on memory efficiency and convenience."
HOMEPAGE="http://www.cliki.net/xml-emitter"
SRC_URI="mirror://gentoo/${P#cl-}.tar.gz"
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
