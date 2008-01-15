# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimmage/gimmage-0.2.3.ebuild,v 1.2 2008/01/15 00:38:51 maekke Exp $

DESCRIPTION="A slim GTK-based image browser"
HOMEPAGE="http://gimmage.berlios.de/"
SRC_URI="http://download.berlios.de/gimmage/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="dev-cpp/cairomm
	>=dev-cpp/gtkmm-2.6.2
	dev-util/pkgconfig
	net-misc/curl
	sys-apps/file
	sys-devel/gettext"

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
