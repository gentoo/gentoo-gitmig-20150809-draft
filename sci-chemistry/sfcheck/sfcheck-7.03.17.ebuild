# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/sfcheck/sfcheck-7.03.17.ebuild,v 1.1 2010/02/06 22:13:13 jlec Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Program for assessing the agreement between the atomic model and X-ray data or EM map"
HOMEPAGE="http://www.ysbl.york.ac.uk/~alexei/sfcheck.html"
#SRC_URI="http://www.ysbl.york.ac.uk/~alexei/downloads/sfcheck.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="ccp4"
IUSE=""

RDEPEND="sci-libs/ccp4-libs"
DEPEND="${RDEPEND}
	!<sci-chmistry/ccp4-apps-6.1.3"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ldflags.patch

	emake \
		-C src \
		clean || die
}

src_compile() {
	MR_FORT="$(tc-getFC) ${FFLAGS}" \
	MR_LIBRARY="-lccp4f" \
	emake \
		-C src \
		all || die
}

src_install() {
	dobin bin/${PN} || die
	dodoc readme ${PN}.com.gz doc/${PN}* || die
}
