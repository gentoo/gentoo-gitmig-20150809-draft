# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-base64/cl-base64-3.3.1.ebuild,v 1.5 2005/03/18 07:39:57 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp package to encode and decode base64 with URI support"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-base64.html
	http://b9.com/debian.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-base64/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="dev-lisp/cl-kmrcl"

CLPACKAGE=cl-base64


src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc COPYING
}
