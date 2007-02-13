# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-1.1.0.ebuild,v 1.1 2007/02/13 11:13:48 mattepiu Exp $

inherit kde

DESCRIPTION="k9copy is a DVD backup utility which allow the copy of one or more titles from a DVD9 to a DVD5"
HOMEPAGE="http://k9copy.free.fr/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="media-video/dvdauthor
	media-libs/libdvdread
	app-cdr/dvd+rw-tools
	>=media-video/vamps-0.98
	>=app-cdr/k3b-0.12.14
	dev-libs/dbus-qt3-old
	sys-apps/hal
	media-video/mplayer"

need-kde 3.3

DOC="README TODO ChangeLog"

src_unpack() {
	unpack ${A}
	cd ${S}
}
