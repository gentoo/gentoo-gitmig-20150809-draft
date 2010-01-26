# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/allpaths/allpaths-3.1.ebuild,v 1.1 2010/01/26 20:43:21 weaver Exp $

EAPI="2"

inherit base

DESCRIPTION="De novo assembly of whole-genome shotgun microreads"
HOMEPAGE="http://www.broadinstitute.org/science/programs/genome-biology/crd"
SRC_URI="ftp://ftp.broad.mit.edu/pub/crd/ALLPATHS/Release-3-0/allpaths-${PV}.tgz
	ftp://ftp.broad.mit.edu/pub/crd/ALLPATHS/Release-3-0/AllPathsV3_Manual_r1.0.docx"

LICENSE="Whitehead-MIT"
SLOT="3"
IUSE=""
KEYWORDS="~amd64"

DEPEND=">=sys-devel/gcc-4.3.2"
RDEPEND=""

S="${WORKDIR}/AllPaths"

src_compile() {
	base_src_compile
	emake install_scripts || die
}

src_install() {
	exeinto /usr/share/${P}/bin
	find bin -type f -executable | xargs doexe || die
	echo "PATH=\"/usr/share/${P}/bin\"" > "${S}/99${P}"
	doenvd "${S}/99${P}" || die
	dosym /usr/share/${P}/bin/RunAllPaths3G /usr/bin/RunAllPaths3G || die
	insinto /usr/share/doc/${PF}
	doins "${DISTDIR}/AllPathsV3_Manual_r1.0.docx"
}
