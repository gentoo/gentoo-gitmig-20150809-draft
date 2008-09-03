# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-cffi/cl-cffi-0.9.1.ebuild,v 1.2 2008/09/03 20:48:27 opfer Exp $

inherit common-lisp

DESCRIPTION="The Common Foreign Function Interface (CFFI)"
HOMEPAGE="http://common-lisp.net/project/cffi/"
SRC_URI="http://common-lisp.net/project/cffi/releases/cffi_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

S=${WORKDIR}/cffi_${PV}

DEPEND="doc? ( dev-lisp/sbcl virtual/texi2dvi sys-apps/texinfo )"

CLPACKAGE=cffi

src_compile() {
	use doc && make -C doc docs
}

src_install() {
	dodir $CLSYSTEMROOT
	insinto $CLSOURCEROOT/$CLPACKAGE
	for i in cffi cffi-tests cffi-examples cffi-uffi-compat; do
		dosym $CLSOURCEROOT/$CLPACKAGE/$i.asd \
			$CLSYSTEMROOT/
	done
	doins -r tests src uffi-compat examples *.asd
	dodoc README HEADER TODO
	dodoc doc/*.txt
	if use doc; then
		doinfo doc/*.info
		insinto /usr/share/doc/${PF}/html
		doins -r doc/{spec,manual}
	fi
}
