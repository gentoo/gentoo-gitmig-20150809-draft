# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/raw-thumbnailer/raw-thumbnailer-0.1.ebuild,v 1.15 2008/01/23 19:08:49 drac Exp $

inherit eutils

DESCRIPTION="A lightweight and fast raw image thumbnailer"
HOMEPAGE="http://code.google.com/p/raw-thumbnailer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/libopenraw
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!media-gfx/gnome-raw-thumbnailer"

pkg_setup() {
	local fail="Re-emerge media-libs/libopenraw with USE gtk."

	if ! built_with_use media-libs/libopenraw gtk; then
		eerror "${fail}"
		die "${fail}"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog
}
