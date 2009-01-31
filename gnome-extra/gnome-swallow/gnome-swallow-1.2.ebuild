# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-swallow/gnome-swallow-1.2.ebuild,v 1.7 2009/01/31 18:35:56 eva Exp $

inherit autotools gnome2

DESCRIPTION="An applet for Gnome2 that 'swallows' normal apps. Useful for docks that are made for other DEs or WMs"
HOMEPAGE="http://interreality.org/~tetron/technology/swallow/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libgtop-2
	>=gnome-base/gnome-panel-2
	>=x11-libs/gtk+-2.2.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} --docdir=/usr/share/doc/${PF}"

src_unpack() {
	gnome2_src_unpack

	# Fix compilation with --as-needed, bug #247521
	epatch "${FILESDIR}/${P}-as-needed.patch"

	eautoreconf
}
