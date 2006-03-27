# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.13.0.ebuild,v 1.1 2006/03/27 06:37:02 ticho Exp $

IUSE=""

DESCRIPTION="A Gnome client for the Music Player Daemon."
HOMEPAGE="http://cms.qballcow.nl/index.php?page=Gnome_Music_Player_Client"
SRC_URI="http://download.qballcow.nl/programs/${PN}-0.13/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.3
	gnome? ( >=gnome-base/gnome-vfs-2.6 )
	dev-perl/XML-Parser
	>=media-libs/libmpd-0.12.0"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

DOCS="AUTHORS ChangeLog NEWS README"

