# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmacaroons/libmacaroons-0.2.0.ebuild,v 1.1 2014/11/23 13:10:21 patrick Exp $

EAPI=5

# depends on python bindings
RESTRICT="test"

inherit eutils

DESCRIPTION="Hyperdex macaroons support library"

HOMEPAGE="http://hyperdex.org"
SRC_URI="http://hyperdex.org/src/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="dev-libs/libsodium
	dev-libs/json-c"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
