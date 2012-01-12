# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/mtdev/mtdev-1.1.0.ebuild,v 1.3 2012/01/12 22:19:37 maekke Exp $

EAPI=4

DESCRIPTION="Multitouch Protocol Translation Library"
HOMEPAGE="http://bitmath.org/code/mtdev/"
SRC_URI="http://bitmath.org/code/mtdev/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE="static-libs"

RDEPEND=">=sys-kernel/linux-headers-2.6"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
