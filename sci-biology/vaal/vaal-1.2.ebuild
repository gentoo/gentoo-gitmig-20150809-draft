# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vaal/vaal-1.2.ebuild,v 1.2 2009/11/12 18:45:22 weaver Exp $

EAPI="2"

inherit base

DESCRIPTION="A variant ascertainment algorithm that can be used to detect SNPs, indels, and other polymorphisms"
HOMEPAGE="http://www.broadinstitute.org/science/programs/genome-biology/crd"
SRC_URI="ftp://ftp.broad.mit.edu/pub/crd/VAAL/VAAL.1.2.tgz
	ftp://ftp.broad.mit.edu/pub/crd/VAAL/VAAL_manual.doc"

LICENSE="Whitehead-MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/boost-1.37.0"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-gcc-x86-no-autocast.patch
)

S="${WORKDIR}/VAAL"

src_install() {
	exeinto /usr/share/${PN}/bin
	doexe bin/* || die
	echo "PATH=\"/usr/share/${PN}/bin\"" > "${S}/99${PN}"
	doenvd "${S}/99${PN}" || die
	dosym /usr/share/${PN}/bin/VAALrun /usr/bin/VAALrun || die
	insinto /usr/share/doc/${PF}
	doins "${DISTDIR}/VAAL_manual.doc"
}
