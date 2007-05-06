# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/coolkey/coolkey-1.1.0.ebuild,v 1.3 2007/05/06 15:41:37 dertobi123 Exp $

DESCRIPTION="Linux Driver support for the CoolKey and CAC products"
HOMEPAGE="http://directory.fedora.redhat.com/wiki/CoolKey"
SRC_URI="http://directory.fedora.redhat.com/download/coolkey/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE="debug"
RDEPEND="sys-apps/pcsc-lite
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable debug) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
}
