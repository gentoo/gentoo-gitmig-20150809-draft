# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-dict/xfce4-dict-0.3.0.ebuild,v 1.2 2008/05/04 11:11:05 drac Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="A plugin to query a Dict server and other dictionary sources"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

DEPEND="dev-util/intltool"

DOCS="AUTHORS ChangeLog README"

src_unpack() {
	unpack ${A}
	echo panel-plugin/aspell.c >> "${S}"/po/POTFILES.skip
}

xfce44_goodies_panel_plugin
