# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.15.1.ebuild,v 1.4 2007/08/13 21:15:40 dertobi123 Exp $

IUSE="gnome session"

DESCRIPTION="A Gnome client for the Music Player Daemon."
HOMEPAGE="http://sarine.nl/gmpc"
SRC_URI="http://download.sarine.nl/${P}/${P}.tar.gz"

KEYWORDS="~amd64 ppc sparc ~x86"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.8
	>=dev-libs/glib-2.10
	>=gnome-base/libglade-2.3
	gnome? ( >=gnome-base/gnome-vfs-2.6 )
	session? ( x11-libs/libSM )
	dev-perl/XML-Parser
	>=media-libs/libmpd-0.14.0
	net-misc/curl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable session sm) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

DOCS="AUTHORS ChangeLog NEWS README"
