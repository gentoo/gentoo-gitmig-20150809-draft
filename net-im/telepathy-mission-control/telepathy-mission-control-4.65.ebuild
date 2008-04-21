# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-mission-control/telepathy-mission-control-4.65.ebuild,v 1.2 2008/04/21 17:24:40 welp Exp $

inherit eutils

DESCRIPTION="Nokia's implementation of a Telepathy Mission Control"
HOMEPAGE="http://mission-control.sourceforge.net/"
SRC_URI="mirror://sourceforge/mission-control/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gnome-keyring"

RDEPEND=">=net-libs/libtelepathy-0.3.2
	net-libs/telepathy-glib
	>=dev-libs/dbus-glib-0.51
	>=gnome-base/gconf-2
	>=dev-util/pkgconfig-0.12.0
	>=dev-libs/glib-2
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.21 )"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	doc? ( >=dev-util/gtk-doc-1.3 )
	virtual/python"

src_compile() {
	econf $(use_enable doc gtk-doc) \
		$(use_enable gnome-keyring keyring) \
		--enable-server \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
}
