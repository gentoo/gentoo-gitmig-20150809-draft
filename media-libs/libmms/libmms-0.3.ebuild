# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmms/libmms-0.3.ebuild,v 1.1 2006/08/26 02:26:36 hanno Exp $

DESCRIPTION="Common library for accessing Microsoft Media Server (MMS) media streaming protocol"

HOMEPAGE="http://libmms.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README* TODO
}
