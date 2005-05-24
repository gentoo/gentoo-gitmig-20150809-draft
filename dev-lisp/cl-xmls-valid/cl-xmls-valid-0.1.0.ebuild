# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xmls-valid/cl-xmls-valid-0.1.0.ebuild,v 1.3 2005/05/24 18:48:37 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp library for validating XML parsed by XMLS against XML DTD style rulesets."
HOMEPAGE="http://www.bobturf.org/software/xmls-valid/
	http://www.cliki.net/xmls-valid"
SRC_URI="http://www.bobturf.org/software/xmls-valid/xmls-valid-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-kmrcl"

CLPACKAGE=xmls-valid

S=${WORKDIR}/xmls-valid

src_install() {
	common-lisp-install xmls-valid.lisp xmls-valid.asd
	common-lisp-system-symlink
	dodoc COPYING
	insinto /usr/share/doc/${PF}/examples
	doins book_*
}
