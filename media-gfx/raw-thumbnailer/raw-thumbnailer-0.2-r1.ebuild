# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/raw-thumbnailer/raw-thumbnailer-0.2-r1.ebuild,v 1.1 2011/04/22 19:48:55 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="A lightweight and fast raw image thumbnailer"
HOMEPAGE="http://code.google.com/p/raw-thumbnailer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/libopenraw[gtk]
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!media-gfx/gnome-raw-thumbnailer"

DOCS="AUTHORS ChangeLog"

src_prepare() {
	epatch "${FILESDIR}"/${P}-return_0_with_success.patch
}
