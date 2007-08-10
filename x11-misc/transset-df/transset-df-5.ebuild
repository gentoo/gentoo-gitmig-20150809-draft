# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/transset-df/transset-df-5.ebuild,v 1.2 2007/08/10 00:15:33 angelos Exp $

DESCRIPTION="a patched version of xorg's transset"
HOMEPAGE="http://forchheimer.se/transset-df/"
SRC_URI="http://forchheimer.se/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/libX11
	x11-proto/xproto"

src_install() {
	dobin transset-df
	dodoc ChangeLog README
}
