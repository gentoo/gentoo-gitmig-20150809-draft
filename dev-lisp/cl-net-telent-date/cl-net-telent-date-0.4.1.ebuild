# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-net-telent-date/cl-net-telent-date-0.4.1.ebuild,v 1.3 2005/03/18 07:33:18 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp utilities for printing and parsing date"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-net-telent-date
	http://www.cliki.net/net-telent-data"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-net-telent-date/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=net-telent-date

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README
}
