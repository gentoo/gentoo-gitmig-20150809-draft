# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-syslog/cl-syslog-0.9.1.ebuild,v 1.1 2003/11/29 20:41:34 mkennedy Exp $

inherit common-lisp

DESCRIPTION="cl-syslog is a Common Lisp library that provides access to the syslog logging facility under Unix."
HOMEPAGE="http://common-lisp.net/project/cl-syslog/"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-uffi"

CLPACKAGE=cl-syslog

S=${WORKDIR}/${PN}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc CREDITS LICENSE README
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
