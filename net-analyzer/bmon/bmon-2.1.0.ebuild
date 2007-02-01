# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bmon/bmon-2.1.0.ebuild,v 1.5 2007/02/01 19:18:23 gustavoz Exp $

inherit toolchain-funcs

NLVER=0.5.0
DESCRIPTION="interface bandwidth monitor"
HOMEPAGE="http://people.suug.ch/~tgr/bmon/"
SRC_URI="http://people.suug.ch/~tgr/bmon/files/${P}.tar.gz
	http://people.suug.ch/~tgr/libnl/files/libnl-${NLVER}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.3-r2"

src_unpack() {
	unpack ${A}
	sed -i -e "s:LIBNL=\":LIBNL=\"-L${WORKDIR}/libnl-${NLVER}/lib :" \
		-e "s:LIBS=\"-lnl:LIBS=\"-L${WORKDIR}/libnl-${NLVER}/lib -lnl:" \
		 ${S}/configure
}

src_compile() {
	cd ${WORKDIR}/libnl-${NLVER}
	econf || die
	emake || die

	cd ${S}
	econf || die
	emake CPPFLAGS="${CXXFLAGS} -I${WORKDIR}/libnl-${NLVER}/include" || die
}


src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog

	cd ${WORKDIR}/libnl-${NLVER}
	make DESTDIR=${D} install || die
}
