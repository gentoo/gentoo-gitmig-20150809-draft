# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.8.1.ebuild,v 1.12 2005/04/01 18:23:45 blubb Exp $

inherit gnome2

DESCRIPTION="Developer help browser"
HOMEPAGE="http://www.imendio.com/projects/devhelp/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="zlib"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gnome-vfs-2.2
	=gnome-extra/libgtkhtml-2*
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog README NEWS TODO"

G2CONF="${G2CONF} $(use_with zlib)"

#see bug #52680; when USE="-zlib" emerge devhelp, portage implodes due 
#to use_with fooling w/ return values.  this is a bandaid so users don't 
#run into it- it should be removed as soon as a portage .51 is stabled
[ 0 == 0 ]
