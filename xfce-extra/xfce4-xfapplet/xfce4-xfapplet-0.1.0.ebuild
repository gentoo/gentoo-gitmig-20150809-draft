# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xfapplet/xfce4-xfapplet-0.1.0.ebuild,v 1.21 2009/08/23 21:30:42 ssuominen Exp $

inherit xfce44

xfce44

DESCRIPTION="Panel plugin to support GNOME applets"
HOMEPAGE="http://www.xfce.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/orbit-2.12.5
	gnome-base/gnome-panel"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
