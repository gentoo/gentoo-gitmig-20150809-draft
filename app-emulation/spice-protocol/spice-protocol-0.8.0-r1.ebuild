# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice-protocol/spice-protocol-0.8.0-r1.ebuild,v 1.2 2011/05/29 11:13:04 fauli Exp $

EAPI=4

inherit eutils

DESCRIPTION="Headers defining the SPICE protocol."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/2ffbca210033be262fc75e6a73742e0f0e6d5242.patch"
}
