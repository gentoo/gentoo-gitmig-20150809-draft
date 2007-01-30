# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdl/gdl-0.7.1.ebuild,v 1.1 2007/01/30 17:20:09 dang Exp $

inherit gnome2

DESCRIPTION="The Gnome Devtool Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libgnome-2.6
	>=gnome-base/libgnomeui-2.6
	>=dev-libs/libxml2-2.4
	>=gnome-base/libglade-2.0
	>=gnome-base/gnome-vfs-2.6"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
