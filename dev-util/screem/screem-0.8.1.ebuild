# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/screem/screem-0.8.1.ebuild,v 1.3 2005/08/25 18:52:20 allanonjl Exp $

inherit gnome2 eutils

DESCRIPTION="SCREEM (Site CReating and Editing EnvironmenMent) is an
integrated environment of the creation and maintenance of websites and
pages"
SRC_URI="http://ftp1.sourceforge.net/screem/${P}.tar.gz"
HOMEPAGE="http://www.screem.org"
KEYWORDS="~x86 sparc ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="ssl zlib"

RDEPEND=">=gnome-base/libgnome-2.2.0
	>=gnome-base/libgnomeui-2.2.0
	>=dev-libs/libxml2-2.4.3
	>=gnome-base/libglade-2.0.0
	>=gnome-base/gconf-2.2.0
	>=gnome-base/gnome-vfs-2.2.0
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	>=gnome-base/libbonobo-2.2.0
	>=gnome-base/libbonoboui-2.2.0
	=gnome-extra/libgtkhtml-2*
	>=gnome-base/libgnomeprint-2.2.0
	>=gnome-base/libgnomeprintui-2.2.0
	>=x11-libs/gtksourceview-0.3.0
	app-text/scrollkeeper
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"


use ssl && G2CONF="$G2CONF --with-ssl"
use zlib || G2CONF="$G2CONF --without-zlib"

DOCS="ABOUT-NLS AUTHORS BUGS ChangeLog INSTALL NEWS README TODO"

src_compile() {

	gnome2_src_configure

	epatch ${FILESDIR}/${P}-makefile-fix.patch

	emake pixmapdir="${prefix}/share" || die "make failed"
}
