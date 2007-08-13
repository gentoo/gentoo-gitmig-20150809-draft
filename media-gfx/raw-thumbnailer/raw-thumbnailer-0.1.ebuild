# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/raw-thumbnailer/raw-thumbnailer-0.1.ebuild,v 1.1 2007/08/13 16:31:35 angelos Exp $

inherit eutils

DESCRIPTION="A lightweight and fast raw image thumbnailer"
HOMEPAGE="http://code.google.com/p/raw-thumbnailer/"
SRC_URI="http://raw-thumbnailer.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libopenraw
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	media-libs/jpeg"

pkg_setup() {
	if ! built_with_use libopenraw gtk ; then
		eerror "media-libs/libopenraw is not built with USE=gtk"
		die "Please rebuild media-libs/libopenraw with USE=gtk"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
