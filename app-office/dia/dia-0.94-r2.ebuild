# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.94-r2.ebuild,v 1.4 2005/08/24 08:54:52 cryos Exp $

inherit eutils gnome2

DESCRIPTION="Diagram/flowchart creation program"
HOMEPAGE="http://www.gnome.org/projects/dia/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 sparc x86"
IUSE="gnome png python static zlib"

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
		>=dev-python/pygtk-1.99 )
	~app-text/docbook-xml-dtd-4.2
	app-text/docbook-xsl-stylesheets"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig"

G2CONF="${G2CONF} $(use_enable gnome) $(use_with python) $(use_enable static)"

DOCS="AUTHORS ChangeLog KNOWN_BUGS NEWS README RELEASE-PROCESS THANKS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Disable python -c 'import gtk' during compile to prevent using
	# X being involved (#31589)
	epatch ${FILESDIR}/${PV}-disable_python_gtk_import.patch

	# Fix generation of the man page (bug #98610).
	rm doc/en/dia.1
	epatch ${FILESDIR}/${P}-db2man.patch
	autoconf || die "Autoconf failed"

	# Disable buggy font cache. See bug #81227.
	epatch ${FILESDIR}/${P}-no_font_cache.patch
	# Fix help display. See bug #83726.
	epatch ${FILESDIR}/${P}-help.patch
	# GCC 4 compile fixes
	epatch ${FILESDIR}/${P}-gcc4.patch
}
