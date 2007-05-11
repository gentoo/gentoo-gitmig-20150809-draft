# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/evolvotron/evolvotron-0.4.0.ebuild,v 1.1 2007/05/11 08:46:08 drac Exp $

inherit qt3 eutils

DESCRIPTION="An interactive generative art application"
HOMEPAGE="http://www.bottlenose.demon.co.uk/share/evolvotron/index.htm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="$(qt_min_version 3)"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/QMAKE_CXXFLAGS_RELEASE .*march/d' \
		-e "/^QMAKE_CXXFLAGS_RELEASE += -O3/ s:=.*:= ${CXXFLAGS}:" \
		-e '/^INSTALLPATH/ s:=.*:= /usr/bin:' "${S}"/common.pro \
		|| die "sed common.pro failed"
	epatch "${FILESDIR}/${PN}-0.3.1-gcc4.patch"
}

src_compile() {
	export PATH=${QTDIR}/bin:${PATH}
	econf fs || die
	emake -j1 || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc BUGS CHANGES README TODO USAGE
}
