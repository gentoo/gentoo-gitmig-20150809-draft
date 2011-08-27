# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/sysbench/sysbench-0.4.12.ebuild,v 1.1 2011/08/27 09:07:03 patrick Exp $

EAPI="2"

inherit autotools

DESCRIPTION="System performance benchmark"
HOMEPAGE="http://sysbench.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aio mysql"

DEPEND="mysql? ( virtual/mysql )
	aio? ( dev-libs/libaio )"
RDEPEND="${DEPEND}"

src_configure() {
	eautoreconf
	if ! use aio; then my_econf="--disable-aio"; fi
	econf $(use_with mysql mysql /usr) $my_econf || die "econf failed"
}
src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
}
