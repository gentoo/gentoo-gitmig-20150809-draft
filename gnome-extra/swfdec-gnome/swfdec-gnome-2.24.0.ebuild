# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/swfdec-gnome/swfdec-gnome-2.24.0.ebuild,v 1.9 2010/07/20 02:21:52 jer Exp $

inherit gnome2 eutils

DESCRIPTION="flash player and thumbnailer for GNOME"
HOMEPAGE="http://swfdec.freedesktop.org/wiki/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12.0
		gnome-base/gconf
		>=media-libs/swfdec-0.8"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext"

DOCS="NEWS"

pkg_setup() {
	if ! built_with_use media-libs/swfdec gtk ; then
		einfo "You must build swfdec with the gtk USE flag to build"
		einfo "swfdec-gtk, which is required by ${PN}"
		die "Please re-emerge media-libs/swfdec with the gtk USE flag"
	fi
}
