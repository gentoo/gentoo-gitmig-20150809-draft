# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-2.6.4.ebuild,v 1.7 2004/12/11 10:27:11 kloeri Exp $

inherit gnome2 eutils

DESCRIPTION="Help browser for GNOME"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~hppa ~amd64 ~ia64 ~mips ~ppc64"

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2.0.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libbonobo-2
	=gnome-extra/libgtkhtml-2*
	>=dev-libs/libxml2-2.6.5
	>=dev-libs/libxslt-1.1.4
	>=gnome-base/libglade-2
	dev-libs/popt
	sys-libs/zlib"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makedepfix.patch
}