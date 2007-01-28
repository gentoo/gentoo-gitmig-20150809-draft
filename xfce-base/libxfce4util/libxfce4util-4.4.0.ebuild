# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.4.0.ebuild,v 1.3 2007/01/28 14:25:52 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Core library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc"

# This library is base of all Xfce packages, so we have blockers here to ensure
# revdep-rebuild doesn't want 4.2 back and forth.

RDEPEND=">=dev-libs/glib-2.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )
	!xfce-extra/xfce4-panelmenu
	!xfce-extra/xfce4-showdesktop
	!xfce-extra/xfce4-systray
	!xfce-extra/xfce4-taskbar
	!xfce-extra/xfce4-toys
	!xfce-extra/xfce4-windowlist
	!xfce-extra/xfce4-trigger-launcher
	!xfce-extra/xfce4-websearch
	!xfce-extra/xfce4-modemlights
	!xfce-extra/xfce4-minicmd
	!xfce-extra/xfce4-megahertz
	!xfce-extra/xfce4-iconbox
	!xfce-extra/xfce4-artwork
	!xfce-base/xffm
	!xfce-extra/xfcalendar
	!xfce-extra/xfce4-bglist-editor"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

xfce44_core_package
