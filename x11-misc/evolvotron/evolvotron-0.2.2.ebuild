# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/evolvotron/evolvotron-0.2.2.ebuild,v 1.3 2004/02/28 19:19:17 aliz Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="An interactive generative art application"
HOMEPAGE="http://www.bottlenose.demon.co.uk/share/evolvotron/index.htm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=x11-libs/qt-3"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/QMAKE_CXXFLAGS_RELEASE .*march/d' \
		-e "/^QMAKE_CXXFLAGS_RELEASE += -O3/ s:=.*:= ${CXXFLAGS}:" \
		-e '/^INSTALLPATH/ s:=.*:= /usr/bin:' ${S}/common.pro || \
			die "sed common.pro failed"
}

src_compile() {
	econf fs  || die
	emake -j1 || die "emake failed"
}

src_install() {
	make INSTALL_ROOT=${D} install || die "make install failed"
	dodoc CHANGES README TODO      || die "dodoc failed"
}
