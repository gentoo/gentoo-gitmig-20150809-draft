# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtorrentviewer/gtorrentviewer-0.2b.ebuild,v 1.7 2011/03/28 14:25:03 nirbheek Exp $

EAPI="1"

inherit eutils gnome2

MY_PN=${PN/gtorrentviewer/GTorrentViewer}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A GTK2-based viewer and editor for BitTorrent meta files"
HOMEPAGE="http://gtorrentviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtorrentviewer/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_P}

RDEPEND="net-misc/curl
	>=x11-libs/gtk+-2.4:2
	>=dev-libs/glib-2.4:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"
