# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gnome-build/gnome-build-0.3.0.ebuild,v 1.7 2009/02/09 21:49:55 maekke Exp $

inherit eutils gnome2 flag-o-matic

DESCRIPTION="The Gnome Build Framework"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
		 >=x11-libs/gtk+-2.4
		 >=dev-libs/gdl-0.7.6
		 >=dev-libs/libxml2-2.6
		 >=gnome-base/libglade-2.0
		 >=gnome-base/libgnome-2.4
		 >=gnome-base/gnome-vfs-2.4
		 >=gnome-base/libgnomeui-2.4
		 >=gnome-base/libbonoboui-2.4
		   dev-perl/Locale-gettext"
DEPEND="${RDEPEND}
		sys-devel/gettext
		dev-util/pkgconfig
		>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	if ! built_with_use 'dev-libs/gdl' 'gnome' ; then
		eerror 'Please build gdl with the gnome useflag.'
		eerror 'echo "dev-libs/gdl gnome" >> /etc/portage/package.use ; emerge -1 gdl'
		die 'gdl built without gnome'
	fi
}

src_compile() {
	# fix for glibc 2.8 (see bug #225447)
	# will not be needed for newer versions, offending code is gone
	append-flags -D_GNU_SOURCE

	gnome2_src_compile
}
