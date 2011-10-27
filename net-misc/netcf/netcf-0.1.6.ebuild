# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netcf/netcf-0.1.6.ebuild,v 1.2 2011/10/27 17:05:33 jer Exp $

EAPI=2

DESCRIPTION="netcf is a cross-platform network configuration library"
HOMEPAGE="https://fedorahosted.org/netcf/"
SRC_URI="https://fedorahosted.org/released/netcf/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-admin/augeas-0.5.0
		dev-libs/libnl:1.1
		dev-libs/libxml2
		dev-libs/libxslt
		sys-libs/readline"
RDEPEND="${DEPEND}"

src_configure() {
	# static libs are a waste of time and disk for this
	econf --disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README NEWS
}
