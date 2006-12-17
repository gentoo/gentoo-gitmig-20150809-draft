# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pida/pida-0.4.1.ebuild,v 1.1 2006/12/17 08:39:00 dev-zero Exp $

inherit distutils

DESCRIPTION="Gtk and/or Vim-based Python Integrated Development Application"
HOMEPAGE="http://pida.berlios.de"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gvim"

DEPEND=">=dev-python/pygtk-2.6
	dev-python/setuptools
	gvim? ( >=app-editors/gvim-6.3 )
	>=x11-libs/vte-0.11.11-r2
	dev-python/kiwi"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use x11-libs/vte python ; then
		eerror "x11-libs/vte has to be built with python USE-flag"
		die "missing python USE-flag for x11-libs/vte"
	fi
}

pkg_postinst() {
	einfo "Optional packages pida integrates with:"
	einfo "app-misc/mc  (Midnight Commander)"
	einfo "dev-util/gazpacho (Glade-like interface designer)"
	einfo "Revision control: cvs, svn, darcs and many others"
}
