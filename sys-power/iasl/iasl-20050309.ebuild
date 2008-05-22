# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/iasl/iasl-20050309.ebuild,v 1.3 2008/05/22 21:21:59 robbat2 Exp $

MY_PN="acpica-unix"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Intel ACPI Source Language (ASL) compiler"
HOMEPAGE="http://www.intel.com/technology/iapc/acpi/"
SRC_URI="${HOMEPAGE}/downloads/${MY_P}.tar.gz"
LICENSE="iASL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc"
S="${WORKDIR}/${MY_P}"

src_compile() {
	cd "${S}"/compiler && emake -j1 || die "make failed"
}

src_install() {
	dobin compiler/iasl || die "iasl binary not created"
	dodoc "${S}"/README || die "README not found"
}
