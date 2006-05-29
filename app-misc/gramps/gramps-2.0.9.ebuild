# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-2.0.9.ebuild,v 1.7 2006/05/29 19:41:47 blubb Exp $

inherit gnome2 eutils

DESCRIPTION="Genealogical Research and Analysis Management Programming System"
HOMEPAGE="http://gramps.sourceforge.net/"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2.0
		 >=dev-lang/python-2.3
		 >=dev-python/pygtk-2.4
		 >=dev-python/gnome-python-2.6
		 >=gnome-base/gnome-vfs-2.8
		 media-gfx/graphviz
		 >=dev-python/reportlab-1.11"
DEPEND="${RDEPEND}
		sys-devel/gettext
		|| ( sys-libs/glibc dev-libs/libiconv )
		app-text/scrollkeeper
		dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

DOCS="NEWS README TODO"
USE_DESTDIR="1"

pkg_setup() {
	if has_version '<dev-python/pygtk-2.8' ; then
		if ! built_with_use dev-python/pygtk gnome ; then
			eerror "You need to install pygtk with libglade support. Try:"
			eerror "USE='gnome' emerge pygtk"
			die "libglade support missing from pygtk"
		fi
	fi

	if ! built_with_use 'dev-lang/python' berkdb ; then
		eerror "You need to install python with Berkely Database support."
		eerror "Add 'dev-lang/python berkdb' to /etc/portage/package.use "
		eerror "and then re-emerge python."
		die "berkdb support missing from gnome"
	fi

	G2CONF="${G2CONF} --disable-mime-install"
}

src_install() {
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
	mv ${D}/usr/share/gramps.desktop ${D}/usr/share/applications/gramps.desktop
}
