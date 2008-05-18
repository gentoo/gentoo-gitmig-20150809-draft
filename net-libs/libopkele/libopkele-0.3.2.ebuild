# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libopkele/libopkele-0.3.2.ebuild,v 1.2 2008/05/18 12:55:27 drac Exp $

DESCRIPTION="a c++ implementation of an OpenID decentralized identity system"
HOMEPAGE="http://kin.klever.net/libopkele/"
SRC_URI="http://kin.klever.net/dist/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libpcre
	dev-libs/openssl
	net-misc/curl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
}
