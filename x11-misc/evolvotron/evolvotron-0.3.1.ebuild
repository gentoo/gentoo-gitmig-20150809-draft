# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/evolvotron/evolvotron-0.3.1.ebuild,v 1.3 2005/06/19 19:18:56 smithj Exp $

DESCRIPTION="An interactive generative art application"
HOMEPAGE="http://www.bottlenose.demon.co.uk/share/evolvotron/index.htm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND=">=x11-libs/qt-3"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/QMAKE_CXXFLAGS_RELEASE .*march/d' \
		-e "/^QMAKE_CXXFLAGS_RELEASE += -O3/ s:=.*:= ${CXXFLAGS}:" \
		-e '/^INSTALLPATH/ s:=.*:= /usr/bin:' ${S}/common.pro \
		|| die "sed common.pro failed"
}

src_compile() {
	econf fs || die
	emake -j1 || die "emake failed"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"
	dodoc BUGS CHANGES README TODO USAGE
}
