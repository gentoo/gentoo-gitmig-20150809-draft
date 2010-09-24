# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vaal/vaal-1.6.ebuild,v 1.2 2010/09/24 15:54:59 weaver Exp $

EAPI="2"

inherit base autotools

DESCRIPTION="A variant ascertainment algorithm that can be used to detect SNPs, indels, and other polymorphisms"
HOMEPAGE="http://www.broadinstitute.org/science/programs/genome-biology/crd"
SRC_URI="ftp://ftp.broad.mit.edu/pub/crd/VAAL/VAAL.${PV}.tgz
	ftp://ftp.broad.mit.edu/pub/crd/VAAL/VAAL_manual.doc"

LICENSE="Whitehead-MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

DEPEND=">=dev-libs/boost-1.41.0-r3"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-respect-flags.patch
)

S="${WORKDIR}/vaal-33805"

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_install() {
	einstall || die
	insinto /usr/share/doc/${PF}
	doins "${DISTDIR}/VAAL_manual.doc"
}
