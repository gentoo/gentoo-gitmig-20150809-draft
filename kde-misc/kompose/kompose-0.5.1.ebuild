# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kompose/kompose-0.5.1.ebuild,v 1.6 2005/06/30 12:58:44 danarmak Exp $

inherit kde

DESCRIPTION="A KDE fullscreen task manager."
HOMEPAGE="http://kompose.berlios.de"
SRC_URI="http://download.berlios.de/kompose/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/imlib2"
RDEPEND="media-libs/imlib2"
need-kde 3.2

function pkg_setup() {
	# bug 94881
	if ! built_with_use media-libs/imlib2 X; then
		eerror "This package requires imlib2 to be built with X11 support."
		eerror "Please run USE=X emerge media-libs/imlib2, then try emerging kompose again."
		die "imlib2 must be built with USE=X"
	fi
}
