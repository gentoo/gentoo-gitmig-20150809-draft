# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-resolver/cl-resolver-0.6.ebuild,v 1.1 2004/11/23 19:58:26 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Resolver is a UFFI interface to Linux's libresolv.so DNS library."
HOMEPAGE="http://www.findinglisp.com/packages/"
SRC_URI="mirror://gentoo/resolver-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/cl-uffi"

CLPACKAGE=resolver

S=${WORKDIR}/resolver-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc COPYING ChangeLog DOCS README
}
