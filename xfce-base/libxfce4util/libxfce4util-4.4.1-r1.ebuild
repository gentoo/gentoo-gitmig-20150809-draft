# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.4.1-r1.ebuild,v 1.3 2007/12/06 10:10:18 opfer Exp $

inherit eutils xfce44

XFCE_VERSION="4.4.1"
xfce44

DESCRIPTION="Basic utilities library"
HOMEPAGE="http://www.xfce.org/projects/libraries"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="debug doc"

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
	!xfce-base/xffm
	!xfce-extra/xfcalendar
	!xfce-extra/xfce4-bglist-editor
	!<xfce-extra/xfce4-genmon-3
	!<xfce-extra/xfce4-diskperf-2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-overflow.patch
}

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

xfce44_core_package
