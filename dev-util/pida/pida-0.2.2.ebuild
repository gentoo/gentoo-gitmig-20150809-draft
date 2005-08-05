# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pida/pida-0.2.2.ebuild,v 1.2 2005/08/05 14:10:45 pythonhead Exp $

inherit distutils

MY_P=${P/-/_}
DESCRIPTION="Gtk and/or Vim-based Python Integrated Development Application"
HOMEPAGE="http://pida.berlios.de"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="gvim gnome"

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pygtk-2.4
	gvim? ( >=app-editors/gvim-6.3 )
	gnome? ( >=x11-libs/gtksourceview-1.2.0
			>=dev-python/gnome-python-2.10 )
	>=x11-libs/vte-0.11.11-r2
	>=dev-python/bicyclerepair-0.9"

pkg_setup() {
	einfo "The 'gnome' USE flag is only needed if you don't use gvim as the"
	einfo "embedded editor."
	if ! use gvim && ! use gnome ; then
		die "You need to have either gvim or gnome (or both) in your USE flags"
	fi
}

pkg_postinst() {
	if ! built_with_use x11-libs/vte python ; then
		ewarn "If you want to use the terminal emulator functionality of pida,"
		ewarn "you will need to recompile x11-libs/vte with USE=\"python\"."
		einfo "Optional packages pida integrates with:"
		einfo "app-misc/mc  (Midnight Commander)"
		einfo "dev-util/gazpacho (Glade-like interface designer)"
		einfo "Revision control: cvs, svn, darcs"
	fi
}

