# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lsyncd/lsyncd-1.33.ebuild,v 1.3 2010/07/22 14:40:16 darkside Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Live Syncing (Mirror) Daemon"
HOMEPAGE="http://code.google.com/p/lsyncd/"
SRC_URI="http://lsyncd.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="xml"

DEPEND="xml? ( dev-libs/libxml2 )"
RDEPEND="${DEPEND}
	net-misc/rsync"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libxml2.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable xml)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO ChangeLog || die
}
