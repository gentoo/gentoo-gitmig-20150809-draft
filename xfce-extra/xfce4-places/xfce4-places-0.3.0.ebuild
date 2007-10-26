# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-places/xfce4-places-0.3.0.ebuild,v 1.10 2007/10/26 13:44:05 angelos Exp $

inherit autotools xfce44

xfce44

DESCRIPTION="Rewrite of GNOME Places menu for panel"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=xfce-base/thunar-${THUNAR_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "/^AC_INIT/s/places_version()/places_version/" configure.ac
	eautoconf
}

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_goodies_panel_plugin
