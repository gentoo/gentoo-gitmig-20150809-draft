# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnome-jabber/gnome-jabber-0.4.ebuild,v 1.12 2005/04/02 00:36:42 weeve Exp $

inherit gnome2

DESCRIPTION="Gnome Jabber Client"
SRC_URI="mirror://sourceforge/gnome-jabber/${P}.tar.bz2"
HOMEPAGE="http://gnome-jabber.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64 ~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0.4
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libglade-2.0.0
	>net-libs/gnet-2
	>=gnome-base/gconf-2.0
	>=dev-libs/libxml2-2.4.23
	sys-devel/gettext
	>=dev-util/intltool-0.29"

DOCS="AUTHORS COPYING ChangeLog README NEWS TODO"

src_unpack () {
	unpack ${A}
	cd ${S}
	sed -i -e 's:/usr/local:/usr:g' gnome-jabber.schemas.in
	intltoolize -f && aclocal && autoconf && automake -a &&
	libtoolize --force --copy || die
}
