# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgtk/kgtk-0.9.1.ebuild,v 1.2 2007/10/09 16:52:00 genstef Exp $

inherit kde

DESCRIPTION="Allows *some* Gtk applications to use KDE's file dialogs when run under KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=36077"
SRC_URI="http://home.freeuk.com/cpdrummond/KGtk-${PV}.tar.bz2"
S=$WORKDIR/KGtk-$PV

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6
	dev-util/cmake"
need-kde 3.4

src_compile() {
	cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=/usr \
		. || die "cmake (configure) failed"

	emake || die "emake failed"
}

pkg_postinst() {
	elog "To see the kde-file-selector in a gtk-application, just do:"
	elog "cd /usr/local/bin"
	elog "ln -s /usr/bin/kgtk-wrapper application(eg. firefox)"
	elog "Make sure that /usr/local/bin is before /usr/bin in your \$PATH"
	elog
	elog "You need to restart kde and be sure to change your symlinks to non-.sh"
}
