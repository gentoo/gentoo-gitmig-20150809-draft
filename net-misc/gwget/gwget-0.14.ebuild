# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwget/gwget-0.14.ebuild,v 1.3 2004/11/04 08:52:35 obz Exp $

inherit gnome2

DESCRIPTION="GTK2 WGet Frontend"
HOMEPAGE="http://gwget.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwget/${P}.tar.gz"
LICENSE="GPL-2"

IUSE="nls"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND=">=net-misc/wget-1.8
	>=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gettext-0.10.4"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

use nls \
	&& G2CONF="${G2CONF} --enable-nls" \
	|| G2CONF="${G2CONF} --disable-nls"

src_install() {

	gnome2_src_install
	# remove extra documentation, keeping /usr/share/doc
	rm -rf ${D}/usr/doc

}
