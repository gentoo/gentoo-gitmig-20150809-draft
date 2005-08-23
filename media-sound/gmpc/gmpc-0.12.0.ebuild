# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.12.0.ebuild,v 1.2 2005/08/23 20:37:51 pylon Exp $

IUSE=""

inherit gnome2

DESCRIPTION="A Gnome client for the Music Player Daemon."
HOMEPAGE="http://etomite.qballcow.nl/qgmpc-0.12.html"
SRC_URI="http://download.qballcow.nl/programs/${PN}/${P}.tar.gz"

KEYWORDS="~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.3
	>=gnome-base/gnome-vfs-2.6
	dev-perl/XML-Parser
	=media-libs/libmpd-0.01"

DOCS="AUTHORS ChangeLog NEWS README"

