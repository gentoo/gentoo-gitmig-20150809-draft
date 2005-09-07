# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-common-idioms/cl-common-idioms-3.ebuild,v 1.1 2005/09/07 14:32:46 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A small Common Lisp library implementing various Common Lisp idioms."
HOMEPAGE="http://www.unmutual.info/software/common-idioms/"
SRC_URI="mirror://gentoo/common-idioms-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

CLPACKAGE=common-idioms

S=${WORKDIR}/common-idioms-${PV}

src_unpack() {
	unpack ${A}
	rm ${S}/Makefile
}

src_install() {
	common-lisp-install *.{asd,lisp}
	common-lisp-system-symlink
	dodoc LICENSE README
	dohtml docs/*.{html,css}
	dohtml -r docs/icons
}
