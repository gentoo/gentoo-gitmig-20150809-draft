# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-shares/thunar-shares-0.2.0.ebuild,v 1.1 2009/02/15 22:05:54 angelos Exp $

EAPI=1

inherit xfce44

xfce44
xfce44_gzipped
xfce44_goodies_thunar_plugin

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="http://code.google.com/p/thunar-shares/"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.10:2
	xfce-base/thunar"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"
