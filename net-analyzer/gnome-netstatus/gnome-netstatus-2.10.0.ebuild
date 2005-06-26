# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnome-netstatus/gnome-netstatus-2.10.0.ebuild,v 1.8 2005/06/26 09:56:12 gmsoft Exp $

inherit gnome2

DESCRIPTION="Network interface information applet"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO MAINTAINERS"
