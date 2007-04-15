# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libjingle/libjingle-0.3.10.ebuild,v 1.1 2007/04/15 17:25:37 genstef Exp $

inherit eutils

DESCRIPTION="Google's jabber voice extension library modified by Tapioca"
HOMEPAGE="http://tapioca-voip.sourceforge.net/"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

RDEPEND="dev-libs/openssl
	dev-libs/expat"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
