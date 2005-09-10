# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bmon/bmon-2.1.0-r1.ebuild,v 1.3 2005/09/10 02:08:06 vanquirius Exp $

inherit toolchain-funcs eutils

NLVER=0.5.0
DESCRIPTION="interface bandwidth monitor"
HOMEPAGE="http://people.suug.ch/~tgr/bmon/"
SRC_URI="http://people.suug.ch/~tgr/bmon/files/${P}.tar.gz
	http://people.suug.ch/~tgr/libnl/files/libnl-${NLVER}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbi rrdtool"

DEPEND=">=sys-libs/ncurses-5.3-r2
	dbi? ( >=dev-db/libdbi-0.7.2-r1 )
	rrdtool? ( >=net-analyzer/rrdtool-1.2.6-r1 )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/libnl-${NLVER}-include.diff
	# gcc4 fix, bug 105343
	epatch ${FILESDIR}/${P}-gcc4.diff
	sed -i -e "s:LIBNL=\":LIBNL=\"-L${WORKDIR}/libnl-${NLVER}/lib :" \
		-e "s:LIBS=\"-lnl:LIBS=\"-L${WORKDIR}/libnl-${NLVER}/lib -lnl:" \
		 ${S}/configure
}

src_compile() {
	cd ${WORKDIR}/libnl-${NLVER}
	econf || die
	emake || die

	cd ${S}
	econf \
		$(use_enable dbi) \
		$(use_enable rrdtool rrd) || die
	emake CPPFLAGS="${CXXFLAGS} -I${WORKDIR}/libnl-${NLVER}/include" || die
}


src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog

	cd ${WORKDIR}/libnl-${NLVER}
	make DESTDIR=${D} install || die
}
