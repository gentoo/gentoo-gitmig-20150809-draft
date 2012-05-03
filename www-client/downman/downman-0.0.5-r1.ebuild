# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/downman/downman-0.0.5-r1.ebuild,v 1.6 2012/05/03 06:01:04 jdhore Exp $

EAPI=3
inherit autotools eutils gnome2

DESCRIPTION="Suite of programs to download files."
HOMEPAGE="http://downman.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc alpha amd64"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	gnome-base/libglade:2.0
	dev-libs/libxml2:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.patch \
		"${FILESDIR}"/${P}-strlen.patch \
		"${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}
