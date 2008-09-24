# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.16.0.ebuild,v 1.1 2008/09/24 18:30:47 angelos Exp $

EAPI=1

DESCRIPTION="A GTK+2 client for the Music Player Daemon"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/GMPC"
SRC_URI="http://download.sarine.nl/download/Programs/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="session"

RDEPEND=">=dev-libs/glib-2.10:2
	dev-perl/XML-Parser
	dev-util/gob
	>=gnome-base/libglade-2.3
	>=media-libs/libmpd-0.16.0
	net-misc/curl
	>=x11-libs/gtk+-2.12:2
	session? ( x11-libs/libSM )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable session sm) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
