# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/iasl/iasl-20051216.ebuild,v 1.2 2008/05/22 21:21:59 robbat2 Exp $

inherit toolchain-funcs eutils

MY_PN=acpica-unix
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Intel ACPI Source Language (ASL) compiler"
HOMEPAGE="http://www.intel.com/technology/iapc/acpi/"
SRC_URI="http://www.intel.com/technology/iapc/acpi/downloads/${MY_P}.tar.gz"

LICENSE="iASL"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"

IUSE=""
DEPEND="sys-devel/bison
		sys-devel/flex"
RDEPEND=""

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d '${S}'" epatch "${FILESDIR}"/${MY_PN}-20051216-buildfixup.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dobin compiler/iasl tools/acpibin/acpibin tools/acpiexec/acpiexec tools/acpisrc/acpisrc
	dodoc README changes.txt
}
