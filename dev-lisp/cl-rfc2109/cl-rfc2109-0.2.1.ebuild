# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rfc2109/cl-rfc2109-0.2.1.ebuild,v 1.1 2005/08/05 14:31:03 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="An implementation of RFC 2109 (ie. HTTP cookies) in Common Lisp"
HOMEPAGE="http://www.cliki.net/rfc2109"
SRC_URI="http://code.microarray.omrf.org/rfc2109/rfc2109-version-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

S=${WORKDIR}/rfc2109-${PV}

DEPEND="dev-lisp/cl-split-sequence"

CLPACKAGE=rfc2109

src_install() {
	common-lisp-install *.{asd,lisp}
	common-lisp-system-symlink
}
