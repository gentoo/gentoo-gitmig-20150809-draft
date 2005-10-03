# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-bind/cl-bind-0.2.ebuild,v 1.1 2005/10/03 14:26:47 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="BIND combines LET*, DESTRUCTURING-BIND and MULTIPLE-VALUE-BIND into a single form."
HOMEPAGE="http://www.cliki.net/bind http://www.metabang.com/"
SRC_URI="http://www.metabang.com/bind_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-plus"

S=${WORKDIR}/bind/dev

CLPACKAGE=bind

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc COPYING
}
