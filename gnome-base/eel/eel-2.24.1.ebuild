# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-2.24.1.ebuild,v 1.13 2010/01/10 16:48:00 fauli Exp $

inherit virtualx gnome2

DESCRIPTION="The Eazel Extentions Library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="test"

# FIXME: needs a running at-spi-registryd (setup a virtual session ?)
RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.15
		 >=x11-libs/gtk+-2.13
		 >=gnome-base/gconf-2.0
		 >=dev-libs/libxml2-2.4.7
		 >=gnome-base/libglade-2.0
		 >=gnome-base/gnome-desktop-2.23.3
		 >=x11-libs/startup-notification-0.8

		 >=gnome-base/libgnome-2.23.0
		 >=gnome-base/libgnomeui-2.8"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19
		test? ( gnome-extra/libgail-gnome )"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README THANKS TODO"

src_test() {
	# replace FEATURES=userpriv, bug #278735
	if [ ${EUID} -ne 0 ]; then
		einfo "Not running as root, skipping tests."
	else
		addwrite "/root/.gnome2"
		Xmake check || die "make check failed"
	fi
}
