# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-sunbird/libopensync-plugin-sunbird-0.22.ebuild,v 1.4 2010/06/22 20:00:38 arfrever Exp $

inherit flag-o-matic

DESCRIPTION="OpenSync Sunbird Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

RDEPEND="=app-pda/libopensync-${PV}*
	net-libs/neon"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	append-flags -Wno-error
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
