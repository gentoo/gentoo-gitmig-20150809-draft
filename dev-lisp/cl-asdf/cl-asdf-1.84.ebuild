# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-asdf/cl-asdf-1.84.ebuild,v 1.2 2004/09/25 03:03:22 ndimiduk Exp $

DEB_PV=1

inherit common-lisp-common eutils

DESCRIPTION="Another System Definition Facility for Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-asdf.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-asdf/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-asdf/cl-asdf_${PV}-${DEB_PV}.diff.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~sparc ~mips ~ppc s390 ~ppc-macos"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch cl-asdf_${PV}-${DEB_PV}.diff
}

src_install() {
	dodir /usr/share/common-lisp/source/asdf
	insinto /usr/share/common-lisp/source/asdf
	doins asdf.lisp wild-modules.lisp
	dodoc LICENSE README
	dodir /usr/share/doc/${P}/examples
	insinto /usr/share/doc/${P}/examples
	doins test/*
	do-debian-credits
}

pkg_postinst() {
	reregister-all-common-lisp-implementations
}
