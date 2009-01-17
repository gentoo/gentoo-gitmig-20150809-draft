# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/sysbench/sysbench-0.4.10.ebuild,v 1.1 2009/01/17 20:33:23 patrick Exp $

DESCRIPTION="System performance benchmark"
HOMEPAGE="http://sysbench.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql"

DEPEND="mysql? ( virtual/mysql )"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_with mysql mysql /usr) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
}

