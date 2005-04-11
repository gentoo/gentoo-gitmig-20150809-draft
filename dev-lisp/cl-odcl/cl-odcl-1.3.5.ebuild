# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-odcl/cl-odcl-1.3.5.ebuild,v 1.7 2005/04/11 08:33:24 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="A Common Lisp library of utility functions."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-odcl"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-odcl/${PN}_${PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=odcl

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-package-lock-gentoo.patch || die
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
	cd ${S}
	epatch ${FILESDIR}/clisp-tests-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp odcl.asd odcl.system
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/odcl/odcl.asd \
		/usr/share/common-lisp/systems/odcl.asd
	dosym /usr/share/common-lisp/source/odcl/odcl.system \
		/usr/share/common-lisp/systems/odcl.system

	insinto /usr/share/common-lisp/source/odcl/tests
	doins tests/*.lisp
	dodoc COPYING ChangeLog NEWS README VERSION
}
