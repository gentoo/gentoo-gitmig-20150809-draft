# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-blowfish/cl-blowfish-0.3.ebuild,v 1.6 2004/07/14 15:22:45 agriffis Exp $

inherit common-lisp

DESCRIPTION="Common Lisp implementation of the Blowfish encryption algorithm."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-blowfish.html
	http://members.optusnet.com.au/apicard/"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-blowfish/cl-blowfish_${PV}.orig.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=blowfish


src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	do-debian-credits
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
