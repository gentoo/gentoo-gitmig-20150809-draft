# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/screem/screem-0.10.2-r1.ebuild,v 1.2 2004/10/17 22:21:19 liquidx Exp $


inherit gnome2 eutils

S=${WORKDIR}/${P}
DESCRIPTION="SCREEM (Site CReating and Editing EnvironmenMent) is an
integrated environment of the creation and maintenance of websites and
pages"
SRC_URI="mirror://sourceforge/screem/${P}.tar.gz"
HOMEPAGE="http://www.screem.org"
KEYWORDS="~x86 ~sparc ~ppc"
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
	>=dev-libs/libcroco-0.5
	app-text/scrollkeeper
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"


use ssl && G2CONF="$G2CONF --with-ssl"
use zlib || G2CONF="$G2CONF --without-zlib"

DOCS="ABOUT-NLS AUTHORS BUGS ChangeLog INSTALL NEWS README TODO"

src_unpack() {
	unpack ${A}

	sed -i -e 's:@pixmapsdir@:${prefix}/share/screem/pixmaps:g' \
		${S}/pixmaps/Makefile.in

	cd ${S}/libegg/toolbar
	epatch ${FILESDIR}/${P}-eggtoolbar.patch
}

src_compile() {
	gnome2_src_configure
	emake  || die "make failed"
}

