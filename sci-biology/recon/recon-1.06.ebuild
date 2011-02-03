# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/recon/recon-1.06.ebuild,v 1.1 2011/02/03 01:58:47 weaver Exp $

EAPI="3"

DESCRIPTION="Automated de novo identification of repeat families from genomic sequences"
HOMEPAGE="http://selab.janelia.org/recon.html
	http://www.repeatmasker.org/RepeatModeler.html"
SRC_URI="http://www.repeatmasker.org/RECON${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/RECON${PV}"

src_prepare() {
	sed -i 's|$path = "";|$path = "/usr/libexec/'${PN}'";|' scripts/recon.pl || die
}

src_compile() {
	emake -C src || die
}

src_install() {
	dobin scripts/* || die
	exeinto /usr/libexec/${PN}
	doexe src/{edgeredef,eledef,eleredef,famdef,imagespread} || die
	dodoc 00README
	insinto /usr/share/${PN}
	doins -r Demos
}
