# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-2.8.2.ebuild,v 1.9 2005/04/02 03:27:28 geoman Exp $

inherit gnome2 eutils

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa ~amd64 ia64 mips"
IUSE=""

RDEPEND="virtual/xft
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2.4
	>=x11-libs/startup-notification-0.4
	>=x11-libs/vte-0.11.10"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	!gnome-base/gnome-core"
# gnome-core overwrite /usr/bin/gnome-terminal

DOCS="AUTHORS ChangeLog README NEWS TODO"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Use login shell by default (#12900) 
	epatch ${FILESDIR}/${PN}-2-default_shell.patch
	# terminal enhancement, inserts a space after a DND URL
	# patch by Zach Bagnall <yem@y3m.net> in #13801
	epatch ${FILESDIR}/${PN}-2-dnd_url_add_space.patch

}
