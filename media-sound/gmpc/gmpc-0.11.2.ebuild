# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.11.2.ebuild,v 1.3 2004/11/23 05:17:03 eradicator Exp $

IUSE=""

inherit gnome2

DESCRIPTION="A Gnome client for the Music Player Daemon."
HOMEPAGE="http://gmpc.qballcow.nl/"
SRC_URI="http://download.qballcow.nl/programs/${PN}/${P}.tar.gz"

KEYWORDS="amd64 ppc ~sparc x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.3
	>=gnome-base/gnome-vfs-2.6
	dev-perl/XML-Parser"

DOCS="AUTHORS ChangeLog NEWS README"

