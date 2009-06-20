# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libservicelog/libservicelog-1.0.1.ebuild,v 1.4 2009/06/20 23:33:38 flameeyes Exp $

inherit eutils autotools

DESCRIPTION="Provides a library for logging service-related events"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"
HOMEPAGE="http://linux-diag.sourceforge.net/servicelog/"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="ppc ~ppc64"
IUSE=""

DEPEND="virtual/libc
dev-db/sqlite"

RDEPEND="${DEPEND}
	virtual/logger"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/libservicelog-1.0.1.patch

	eautoreconf
}

src_install () {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog || die
}
