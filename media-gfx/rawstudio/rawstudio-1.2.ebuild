# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/rawstudio/rawstudio-1.2.ebuild,v 1.1 2009/04/27 19:15:30 maekke Exp $

inherit eutils

DESCRIPTION="a program to read and manipulate raw images from digital cameras."
HOMEPAGE="http://rawstudio.org"
SRC_URI="http://${PN}.org/files/release/${P}.tar.gz"

LICENSE="GPL-2 CCPL-Attribution-NoDerivs-2.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.4
	>=gnome-base/gconf-2
	media-gfx/exiv2
	media-libs/jpeg
	media-libs/lcms
	media-libs/tiff
	sys-apps/dbus
	>=x11-libs/gtk+-2.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
