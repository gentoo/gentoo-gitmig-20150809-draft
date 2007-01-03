# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.13.0.ebuild,v 1.4 2007/01/03 02:50:49 ticho Exp $

IUSE="gnome"

DESCRIPTION="A Gnome client for the Music Player Daemon."
HOMEPAGE="http://sarine.nl/gmpc"
SRC_URI="http://download.qballcow.nl/programs/${P%.*}/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.3
	gnome? ( >=gnome-base/gnome-vfs-2.6 )
	dev-perl/XML-Parser
	>=media-libs/libmpd-0.12.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

DOCS="AUTHORS ChangeLog NEWS README"

