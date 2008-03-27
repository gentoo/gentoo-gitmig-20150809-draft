# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-asdf/cl-asdf-1.86-r1.ebuild,v 1.12 2008/03/27 16:37:30 armin76 Exp $

DEB_PV=1

inherit eutils

DESCRIPTION="ASDF is Another System Definition Facility for Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-asdf"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/cl-asdf_${PV}-${DEB_PV}.diff.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	epatch cl-asdf_${PV}-${DEB_PV}.diff || die
}

src_install() {
	insinto /usr/share/common-lisp/source/asdf
	doins asdf.lisp wild-modules.lisp asdf-install.lisp
	dodoc LICENSE README
	insinto /usr/share/doc/${PF}/examples
	doins test/*
}
