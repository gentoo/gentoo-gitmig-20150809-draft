# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnome-jabber/gnome-jabber-0.4.ebuild,v 1.14 2006/02/25 00:08:31 tester Exp $

inherit gnome2 autotools

DESCRIPTION="Gnome Jabber Client"
SRC_URI="mirror://sourceforge/gnome-jabber/${P}.tar.bz2"
HOMEPAGE="http://gnome-jabber.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ~ppc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.4
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libglade-2.0.0
	>net-libs/gnet-2
	>=gnome-base/gconf-2.0
	>=dev-libs/libxml2-2.4.23
	sys-devel/gettext"

DEPEND=">=sys-devel/automake-1.7
	>=dev-util/intltool-0.29i
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog README NEWS TODO"

src_unpack () {
	unpack ${A}
	cd ${S}
	sed -i -e 's:/usr/local:/usr:g' gnome-jabber.schemas.in
	intltoolize -f || die
	WANT_AUTOMAKE=1.7 eautoreconf
}
