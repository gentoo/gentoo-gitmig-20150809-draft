# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-md5/cl-md5-1.8.3.ebuild,v 1.2 2004/06/24 23:46:56 agriffis Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp package for MD5 Message Digests"
HOMEPAGE="http://www.pmsf.de/resources/lisp/MD5.html http://packages.debian.org/unstable/devel/cl-md5.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-md5/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=md5

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
}
