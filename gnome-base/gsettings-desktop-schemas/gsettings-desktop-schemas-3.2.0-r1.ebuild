# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gsettings-desktop-schemas/gsettings-desktop-schemas-3.2.0-r1.ebuild,v 1.1 2011/10/29 06:45:15 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Collection of GSettings schemas for GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"

RDEPEND=">=dev-libs/glib-2.21:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.40"

DOCS="AUTHORS HACKING NEWS README"

src_prepare() {
	# Upstream patch to use x-content/unix-software like all of gnome-3.2.1,
	# will be in next release
	epatch "${FILESDIR}/${P}-unix-software.patch"
	gnome2_src_prepare
}
