# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/raw-thumbnailer/raw-thumbnailer-0.2.1.ebuild,v 1.7 2012/01/04 20:25:06 ranger Exp $

EAPI=4

DESCRIPTION="A lightweight and fast raw image thumbnailer"
HOMEPAGE="http://code.google.com/p/raw-thumbnailer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/libopenraw[gtk]
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!media-gfx/gnome-raw-thumbnailer"

DOCS=( AUTHORS ChangeLog )
