# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/rawstudio/rawstudio-0.7.ebuild,v 1.1 2008/02/04 15:08:49 drac Exp $

inherit eutils

DESCRIPTION="a program to read and manipulate raw images from digital cameras."
HOMEPAGE="http://rawstudio.org"
SRC_URI="http://${PN}.org/files/release/${P}.tar.gz"

LICENSE="GPL-2 CCPL-Attribution-NoDerivs-2.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/jpeg
	media-libs/tiff
	>=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.4
	media-libs/lcms
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.6-desktop-entry.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
