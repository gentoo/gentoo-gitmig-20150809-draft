# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libservicelog/libservicelog-1.0.1.ebuild,v 1.3 2009/03/30 20:22:23 ranger Exp $

inherit eutils

S=${WORKDIR}/${PN}-${PV}
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
	epatch "${FILESDIR}"/libservicelog-1.0.1.patch.gz
}

src_compile() {
	econf
}
src_install () {
	emake install DESTDIR="${D}"
	dodoc ChangeLog
}
