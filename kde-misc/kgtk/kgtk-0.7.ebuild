# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgtk/kgtk-0.7.ebuild,v 1.2 2006/09/01 15:00:15 genstef Exp $

inherit kde

DESCRIPTION="Allows *some* Gtk applications to use KDE's file dialogs when run under KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=36077"
SRC_URI="http://home.freeuk.com/cpdrummond/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6"
need-kde 3.4

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/kgtk-no-local.diff
}

pkg_postinst() {
	einfo "To see the kde-file-selector in a gtk-application, just do:"
	echo "cd /usr/local/bin"
	echo "ln -s /usr/bin/kgtk-wrapper.sh application(eg. firefox)"
	einfo "Make sure that /usr/local/bin is before /usr/bin in your \$PATH"
	einfo
	ewarn "Kded needs to be running to get this working!"
}
