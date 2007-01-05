# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-2.2.2.ebuild,v 1.3 2007/01/05 19:12:36 compnerd Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools eutils gnome2

DESCRIPTION="Genealogical Research and Analysis Management Programming System"
HOMEPAGE="http://gramps.sourceforge.net/"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2.8
		 >=dev-lang/python-2.3
		 >=dev-python/pygtk-2.4
		 >=dev-python/gnome-python-2.6
		 >=gnome-base/gnome-vfs-2.8
		 >=app-text/gnome-doc-utils-0.6.1
		 media-gfx/graphviz
		 >=dev-python/reportlab-1.11"
DEPEND="${RDEPEND}
		sys-devel/gettext
		|| ( sys-libs/glibc dev-libs/libiconv )
		app-text/scrollkeeper
		dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

DOCS="NEWS README TODO"

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

src_unpack() {
	gnome2_src_unpack
	cd ${S}

	epatch ${FILESDIR}/${PN}-2.2.2-desktop-entry-icon.patch
	eautomake
}

src_install() {
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
	mv ${D}/usr/share/gramps.desktop ${D}/usr/share/applications/gramps.desktop
}
