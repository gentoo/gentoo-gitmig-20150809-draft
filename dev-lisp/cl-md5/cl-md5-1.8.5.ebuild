# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-md5/cl-md5-1.8.5.ebuild,v 1.4 2007/02/03 17:36:46 flameeyes Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp package for MD5 Message Digests"
HOMEPAGE="http://www.pmsf.de/resources/lisp/MD5.html http://packages.debian.org/unstable/devel/cl-md5.html"
SRC_URI="mirror://debian/pool/main/c/cl-md5/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=md5

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	do-debian-credits
}
