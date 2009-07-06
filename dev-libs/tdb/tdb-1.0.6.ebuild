# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tdb/tdb-1.0.6.ebuild,v 1.25 2009/07/06 18:26:26 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A Trivial Database"
HOMEPAGE="http://sourceforge.net/projects/tdb"
SRC_URI="mirror://sourceforge/tdb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="!net-fs/samba
	!net-fs/samba-libs"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc3.patch \
		"${FILESDIR}"/${P}-no-gdbm.patch
	eautoreconf #243950
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
}
