# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liboobs/liboobs-2.22.0.ebuild,v 1.1 2008/03/23 13:14:41 eva Exp $

inherit gnome2

DESCRIPTION="Liboobs is a wrapping library to the System Tools Backends."
HOMEPAGE="http://www.gnome.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# FIXME: according to the ChangLog hal is optional but it doesn't
# have a configure switch
# FIXME: check if policykit should be checked in configure ?

RDEPEND=">=dev-libs/glib-2.14
	>=dev-libs/dbus-glib-0.70
	>=app-admin/system-tools-backends-2.5.4
	>=sys-apps/hal-0.5.9"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README"
