# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dateutils/dateutils-0.1.5.ebuild,v 1.1 2011/10/15 19:33:02 radhermit Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Command line date and time utilities"
HOMEPAGE="http://hroptatyr.github.com/dateutils/"
SRC_URI="mirror://github/hroptatyr/${PN}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/xz-utils"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.1.5_rc2-header.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}"
}
