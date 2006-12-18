# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-2.16.1.ebuild,v 1.6 2006/12/18 15:25:14 gustavoz Exp $

inherit eutils gnome2

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/xft
	>=x11-libs/gtk+-2.10
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.8
	>=x11-libs/vte-0.13.4
	>=gnome-base/gnome-vfs-2.4
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2"
DEPEND="${RDEPEND}
	!gnome-base/gnome-core
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/scrollkeeper-0.3.11"
# gnome-core overwrite /usr/bin/gnome-terminal

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# Use login shell by default (#12900) 
	epatch ${FILESDIR}/${PN}-2-default_shell.patch

	# terminal enhancement, inserts a space after a DND URL
	# patch by Zach Bagnall <yem@y3m.net> in #13801
	epatch ${FILESDIR}/${PN}-2-dnd_url_add_space.patch

	# patch gnome terminal to report as GNOME rather than xterm
	# This needs to resolve a few bugs (#120294,)
	# Leave out for now; causing too many problems
	#epatch ${FILESDIR}/${PN}-2.13.90-TERM-gnome.patch

	# patch to prevent gnome-term from resizing its windows when
	# switching tabs
	# Gnome Bug http://bugzilla.gnome.org/show_bug.cgi?id=338913
	# Using patch from http://bugzilla.gnome.org/show_bug.cgi?id=95316
	epatch ${FILESDIR}/${PN}-2.15-tab-switching-no-resize.patch
}
