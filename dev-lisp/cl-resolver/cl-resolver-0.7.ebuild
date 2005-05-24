# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-resolver/cl-resolver-0.7.ebuild,v 1.3 2005/05/24 18:48:35 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Resolver is a UFFI interface to the GLIBC libresolv.so DNS library."
HOMEPAGE="http://www.findinglisp.com/packages/"
SRC_URI="mirror://gentoo/resolver-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/cl-uffi"

CLPACKAGE=resolver

S=${WORKDIR}/resolver-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc COPYING ChangeLog DOCS README
}
