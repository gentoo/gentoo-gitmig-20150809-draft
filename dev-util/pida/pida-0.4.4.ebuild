# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pida/pida-0.4.4.ebuild,v 1.1 2007/05/16 04:47:37 pythonhead Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Gtk and/or Vim-based Python Integrated Development Application"
HOMEPAGE="http://pida.co.uk/"
SRC_URI="http://pida.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gvim gnome"

DEPEND=">=dev-python/pygtk-2.8
	>=dev-python/setuptools-0.6_rc3
	gvim? ( >=app-editors/gvim-6.3 )
	gnome? ( >=dev-python/gnome-python-extras-2.14.0-r1 )
	>=x11-libs/vte-0.11.11-r2
	>=dev-python/kiwi-1.9.1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	#Squelch import warnings for un-installed extras
	sed -e "s/self.log.warn/self.log.info/" \
		-i ./pida/core/services.py || die "sed failed"
}

pkg_setup() {
	if ! built_with_use x11-libs/vte python ; then
		eerror "x11-libs/vte has to be built with python USE-flag"
		die "missing python USE-flag for x11-libs/vte"
	fi
}

pkg_postinst() {
	elog "Optional packages pida integrates with:"
	elog "app-misc/mc  (Midnight Commander)"
	elog "dev-util/gazpacho (Glade-like interface designer)"
	elog "Revision control: cvs, svn, darcs and many others"
}

