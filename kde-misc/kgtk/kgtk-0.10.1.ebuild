# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgtk/kgtk-0.10.1.ebuild,v 1.1 2009/03/12 15:15:44 scarabeus Exp $

EAPI="2"

NEED_KDE="none"
inherit kde4-base

DESCRIPTION="Allows *some* Gtk, Qt3, and Qt4 applications to use KDE's file dialogs when run under KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=36077"
SRC_URI="http://home.freeuk.com/cpdrummond/KGtk-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="qt3 +qt4"

DEPEND="
	x11-libs/gtk+:2
	qt4? (
		x11-libs/qt-gui:4
		>=kde-base/kdebase-startkde-4.2.0
	)
	qt3? (
		x11-libs/qt:3
		|| ( kde-base/kdebase:3.5  kde-base/kdebase-startkde:3.5 )
	)
	!qt3? (
		x11-libs/qt-gui:4
		>=kde-base/kdebase-startkde-4.2.0
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/KGtk-${PV}"

src_configure() {
	if use qt3 && use qt4 ; then
		elog "You enabled both qt3 and qt4 useflags. Please pick only one you want."
		elog "qt3 flag will be suppressed in favor of qt4."
	fi
	if use qt3 ; then
		if ! use qt4 ; then
			einfo "Building kgtk with KDE3 support."
			# override prefix (dont let kdeprefix handle it)
			PREFIX="/usr"
			mycmakeargs="-DKGTK_KDE3=true -DKGTK_QT3=true -DKGTK_GTK2=true"
		fi
	fi
	if use qt4 ; then
		einfo "Buiding kgtk with KDE4 support."
		mycmakeargs="-DKGTK_KDE4=true -DKGTK_QT4=true -DKGTK_GTK2=true"
	elif ! use qt3 ; then
		einfo "Buiding kgtk with KDE4 support."
		mycmakeargs="-DKGTK_KDE4=true -DKGTK_QT4=true -DKGTK_GTK2=true"
	fi
	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install
	dodoc ${S}/{AUTHORS,ChangeLog,TODO,README}
}

pkg_postinst() {
	kde4-base_pkg_postinst
	elog "To see the kde-file-selector in a gtk-application, just do:"
	elog "cd /usr/local/bin"
	elog "ln -s /usr/bin/kgtk-wrapper application(eg. firefox)"
	elog "Make sure that /usr/local/bin is before /usr/bin in your \$PATH"
	elog
	elog "You need to restart kde and be sure to change your symlinks to non-.sh"
}
