# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-2.11.2.ebuild,v 1.1 2005/08/21 21:20:53 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="static"

RDEPEND="virtual/xft
	>=x11-libs/gtk+-2.5.4
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.8
	>=x11-libs/vte-0.11.10
	>=gnome-base/gnome-vfs-2.4
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	!gnome-base/gnome-core"
# gnome-core overwrite /usr/bin/gnome-terminal

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"


pkg_setup() {
	G2CONF="$(use_enable static)"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Use login shell by default (#12900) 
	epatch ${FILESDIR}/${PN}-2-default_shell.patch
	# terminal enhancement, inserts a space after a DND URL
	# patch by Zach Bagnall <yem@y3m.net> in #13801
	epatch ${FILESDIR}/${PN}-2-dnd_url_add_space.patch
}
