# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.9.ebuild,v 1.1 2004/06/21 21:52:46 foser Exp $

inherit gnome2

DESCRIPTION="Developer help browser"
HOMEPAGE="http://www.imendio.com/projects/devhelp/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="zlib"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.4
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gnome-vfs-2.2
	net-www/mozilla
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog README NEWS TODO"

G2CONF="${G2CONF} $(use_with zlib)"
