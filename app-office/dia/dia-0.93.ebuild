# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.93.ebuild,v 1.8 2004/12/11 17:05:12 kloeri Exp $

inherit eutils gnome2

DESCRIPTION="Diagram/flowchart creation program"
HOMEPAGE="http://www.gnome.org/projects/dia/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE="gnome png python zlib"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-libs/pango-1.1.5
	>=dev-libs/libxml2-2.3.9
	>=dev-libs/libxslt-1
	>=media-libs/freetype-2.0.9
	dev-libs/popt
	zlib? ( sys-libs/zlib )
	png? ( media-libs/libpng
		>=media-libs/libart_lgpl-2 )
	gnome? ( >=gnome-base/libgnome-2.0
		>=gnome-base/libgnomeui-2.0 )
	python? ( >=dev-lang/python-1.5.2
		>=dev-python/pygtk-1.99 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig"

G2CONF="${G2CONF} $(use_enable gnome) $(use_with python)"

DOCS="AUTHORS ChangeLog KNOWN_BUGS NEWS README RELEASE-PROCESS THANKS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-fix_py_prefix.patch
}
