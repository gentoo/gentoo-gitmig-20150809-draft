# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-yaclml-darcs/cl-yaclml-darcs-20060825.ebuild,v 1.1 2006/08/25 05:56:45 mkennedy Exp $

EDARCS_REPOSITORY="http://common-lisp.net/project/bese/repos/yaclml/"

inherit eutils multilib darcs common-lisp

DESCRIPTION="YACLML is a collection of macros and utilities for generating XML/HTML like markup from lisp code."
HOMEPAGE="http://common-lisp.net/project/bese/yaclml.html"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~ppc"
IUSE=""
DEPEND="dev-lisp/cl-arnesi-darcs
	dev-lisp/cl-iterate"

CLPACKAGE=yaclml

src_install() {
	common-lisp-install yaclml.asd
	common-lisp-system-symlink
	insinto ${CLSOURCEROOT}/${CLPACKAGE}/
	doins -r src t
	dodoc README COPYING
}
