# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/couriersrs/couriersrs-0.1.2.ebuild,v 1.1 2009/12/05 20:15:50 hanno Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="SRS (Sender Rewriting Scheme) wrapper for the courier MTA."
HOMEPAGE="http://couriersrs.com/"
SRC_URI="http://couriersrs.com/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="dev-libs/popt
	mail-filter/libsrs2"
RDEPEND="${DEPEND}"

src_prepare() {
	rm m4/*.m4
	epatch "${FILESDIR}/${P}-automake-fixes.diff"
	AT_M4DIR="m4" eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS ChangeLog
}
