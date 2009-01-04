# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/augustus/augustus-2.0.3.ebuild,v 1.2 2009/01/04 00:34:08 weaver Exp $

inherit eutils

DESCRIPTION="Eukaryotic gene predictor"
HOMEPAGE="http://augustus.gobics.de/"
SRC_URI="http://augustus.gobics.de/binaries/${PN}.${PV}.src.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-*.patch
}

src_compile() {
	emake -C src || die
}

src_install() {
	dobin src/{augustus,etraining} || die
	insinto /usr/share/${PN}
	doins -r config examples scripts || die
	echo "AUGUSTUS_CONFIG_PATH=\"/usr/share/${PN}/config\"" > "${S}/99${PN}"
	doenvd "${S}/99${PN}" || die
	dodoc README.TXT HISTORY.TXT
}
