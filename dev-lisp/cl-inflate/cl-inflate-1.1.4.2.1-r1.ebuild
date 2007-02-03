# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-inflate/cl-inflate-1.1.4.2.1-r1.ebuild,v 1.7 2007/02/03 17:35:40 flameeyes Exp $

inherit common-lisp

DESCRIPTION="Common Lisp package to decompress gzip, jar, and winzip files."
HOMEPAGE="http://opensource.franz.com/deflate/index.html
	http://packages.debian.org/unstable/devel/cl-inflate.html"
SRC_URI="mirror://debian/pool/main/c/cl-inflate/${PN}_${PV}.orig.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=inflate


src_install() {
	common-lisp-install inflate.lisp ${FILESDIR}/inflate.asd
	common-lisp-system-symlink
}
