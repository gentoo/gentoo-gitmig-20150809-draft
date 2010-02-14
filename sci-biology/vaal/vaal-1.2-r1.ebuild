# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vaal/vaal-1.2-r1.ebuild,v 1.1 2010/02/14 19:50:10 weaver Exp $

EAPI="2"

inherit base

DESCRIPTION="A variant ascertainment algorithm that can be used to detect SNPs, indels, and other polymorphisms"
HOMEPAGE="http://www.broadinstitute.org/science/programs/genome-biology/crd"
SRC_URI="ftp://ftp.broad.mit.edu/pub/crd/VAAL/VAAL.${PV}.tgz
	ftp://ftp.broad.mit.edu/pub/crd/VAAL/VAAL_manual.doc"

LICENSE="Whitehead-MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/boost-1.37.0"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-gcc-x86-no-autocast.patch
	"${FILESDIR}"/${P}-as-needed.patch
	"${FILESDIR}"/${P}-respect-flags.patch
)

S="${WORKDIR}/VAAL"

src_install() {
	exeinto /usr/libexec/${PN}
	doexe bin/* || die
	echo "PATH=\"/usr/libexec/${PN}\"" > "${S}/99${PN}"
	doenvd "${S}/99${PN}" || die
	dosym /usr/libexec/${PN}/VAALrun /usr/bin/VAALrun || die
	insinto /usr/share/doc/${PF}
	doins "${DISTDIR}/VAAL_manual.doc"
}
