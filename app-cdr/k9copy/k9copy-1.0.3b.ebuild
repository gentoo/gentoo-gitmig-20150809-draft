# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-1.0.3b.ebuild,v 1.4 2007/08/22 20:41:18 keytoaster Exp $

inherit kde

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5"
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="http://k9copy.sourceforge.net/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="media-video/dvdauthor
	media-libs/libdvdread
	app-cdr/dvd+rw-tools
	>=media-video/vamps-0.98
	>=app-cdr/k3b-0.12.10"
need-kde 3.3

DOC="README TODO ChangeLog"

src_unpack() {
	kde_src_unpack

	# Fix the desktop file for compliance with the spec.
	sed -i -e '/MimeTypes/d' ${S}/src/${PN}.desktop
}
