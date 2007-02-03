# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-net-telent-date/cl-net-telent-date-0.4.1.ebuild,v 1.6 2007/02/03 17:37:47 flameeyes Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp utilities for printing and parsing date"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-net-telent-date
	http://www.cliki.net/net-telent-data"
SRC_URI="mirror://debian/pool/main/c/cl-net-telent-date/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=net-telent-date

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README
}
