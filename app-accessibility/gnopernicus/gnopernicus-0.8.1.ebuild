# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnopernicus/gnopernicus-0.8.1.ebuild,v 1.1 2004/03/25 04:39:41 leonardop Exp $

inherit eutils gnome2

IUSE="ipv6"
# Local USE flags
IUSE="${IUSE} brltty"

DESCRIPTION="Software tools for blind and visually impaired in Gnome 2"
HOMEPAGE="http://www.baum.ro/gnopernicus.html"

SLOT="1"
KEYWORDS="~x86 ~sparc ~hppa ~alpha ~ia64 ~ppc ~amd64"
LICENSE="LGPL-2"

# libgail-gnome is only required during runtime

RDEPEND=">=gnome-base/gconf-1.1.5
	>=dev-libs/popt-1.5
	>=gnome-base/libgnome-1.102
	>=gnome-base/libgnomeui-1.106
	>=dev-libs/glib-1.3.12
	>=x11-libs/gtk+-1.3
	>=dev-libs/libxml2-2.4.6
	>=gnome-base/libglade-1.99.4
	>=gnome-extra/at-spi-1.3.11
	>=app-accessibility/gnome-speech-0.3
	>=app-accessibility/gnome-mag-0.9
	>=gnome-extra/libgail-gnome-1.0
	virtual/x11
	brltty? ( app-accessibility/brltty )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	dev-util/pkgconfig"

G2CONF="${G2CONF} --with-default-fonts-path=${D}/usr/share/fonts/default/Type1"
G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable brltty)"

DOCS="AUTHORS ChangeLog COPYING NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-brltty_fix.patch
}
