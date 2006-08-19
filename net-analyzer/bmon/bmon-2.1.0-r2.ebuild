# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bmon/bmon-2.1.0-r2.ebuild,v 1.8 2006/08/19 12:56:39 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="interface bandwidth monitor"
HOMEPAGE="http://people.suug.ch/~tgr/bmon/"
SRC_URI="http://people.suug.ch/~tgr/bmon/files/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86"
IUSE="dbi rrdtool"

DEPEND=">=sys-libs/ncurses-5.3-r2
	>=dev-libs/libnl-0.5.0
	dbi? ( >=dev-db/libdbi-0.7.2-r1 )
	rrdtool? ( >=net-analyzer/rrdtool-1.2.6-r1 )"

src_unpack() {
	unpack ${A}
	# gcc4 fix, bug 105343
	epatch ${FILESDIR}/${P}-gcc4.diff

	# Don't strip, bug #144370
	cd ${S}
	epatch ${FILESDIR}/${PN}-nostrip.patch
}

src_compile() {
	econf \
		$(use_enable dbi) \
		$(use_enable rrdtool rrd) || die
	emake CPPFLAGS="${CXXFLAGS} -I${WORKDIR}/libnl-${NLVER}/include" || die
}


src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
