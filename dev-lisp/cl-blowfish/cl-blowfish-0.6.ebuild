# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-blowfish/cl-blowfish-0.6.ebuild,v 1.5 2005/03/18 07:41:20 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp implementation of the Blowfish encryption algorithm."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-blowfish.html http://members.optusnet.com.au/apicard/"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-blowfish/cl-blowfish_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-blowfish/cl-blowfish_${PV}-${DEB_PV}.diff.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=blowfish


src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	do-debian-credits
}
