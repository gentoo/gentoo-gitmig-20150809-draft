# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/augustus/augustus-2.1.ebuild,v 1.3 2009/10/31 17:55:20 maekke Exp $

EAPI="1"
inherit eutils

DESCRIPTION="Eukaryotic gene predictor"
HOMEPAGE="http://augustus.gobics.de/"
SRC_URI="http://augustus.gobics.de/binaries/${PN}.${PV}.src.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_compile() {
	emake -C src clean || die
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
