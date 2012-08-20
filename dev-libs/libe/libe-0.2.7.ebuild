# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libe/libe-0.2.7.ebuild,v 1.2 2012/08/20 13:07:40 patrick Exp $
EAPI=4

inherit eutils

DESCRIPTION="Hyperdex libe support library"

HOMEPAGE="http://hyperdex.org"
SRC_URI="http://hyperdex.org/src/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="dev-libs/libpo6"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/libe-getpid.patch"
}
