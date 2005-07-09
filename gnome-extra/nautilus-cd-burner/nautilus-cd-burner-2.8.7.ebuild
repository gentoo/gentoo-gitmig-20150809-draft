# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-2.8.7.ebuild,v 1.10 2005/07/09 18:54:19 swegener Exp $

inherit gnome2 eutils

DESCRIPTION="CD and DVD writer plugin for Nautilus"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE="dvdr hal"

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.6
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	virtual/cdrtools
	hal? ( >=sys-apps/hal-0.2.98 )
	dvdr? ( app-cdr/dvd+rw-tools )"

DEPEND=">=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9.0
	${RDEPEND}"

G2CONF="${G2CONF} $(use_enable hal)"
DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"

pkg_setup() {

	# Check for USE="unicode" cdrtools, see bug #80053
	if ! built_with_use cdrtools unicode; then
		echo
		eerror "mkisofs needs to support utf8 for ${P}"
		einfo "Please remerge cdrtools with unicode (utf8) support,"
		einfo "     USE=\"unicode\" emerge cdrtools"
		die "mkisofs does not support -input-charset utf8"
	fi

}
