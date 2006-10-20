# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcalctool/gcalctool-5.8.16.ebuild,v 1.11 2006/10/20 22:39:19 agriffis Exp $

inherit eutils gnome2

DESCRIPTION="A calculator application for GNOME"
HOMEPAGE="http://calctool.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-libs/atk-1.5
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.1.9"

DEPEND="${RDEPEND}
	sys-devel/flex
	>=dev-util/intltool-0.35
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog* MAINTAINERS NEWS README TODO"

src_install() {
	gnome2_src_install

	# remove symlink that conflicts with <2.3 gnome-utils
	rm -f ${D}/usr/bin/gnome-calculator
}
