# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gwaei/gwaei-0.13.2.ebuild,v 1.1 2009/01/19 12:12:31 matsuu Exp $

inherit gnome2

DESCRIPTION="Japanese-English Dictionary for GNOME"
HOMEPAGE="http://gwaei.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwaei/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.12
	>=gnome-base/libgnome-2.22
	>=gnome-base/libgnomeui-2.22
	>=gnome-base/gconf-2.22
	>=net-misc/curl-7.18
	>=dev-libs/glib-2.16
	>=x11-libs/libsexy-0.1.11
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.17 )
	dev-util/pkgconfig"

G2CONF="$(use_enable nls) --disable-schemas-install"

src_install() {
	gnome2_src_install

	rm -rf "${D}/usr/share/doc/${P}"
	dodoc AUTHORS ChangeLog NEWS README
}
