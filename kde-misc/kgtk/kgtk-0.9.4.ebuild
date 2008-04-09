# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgtk/kgtk-0.9.4.ebuild,v 1.2 2008/04/09 18:15:14 ingmar Exp $

ARTS_REQUIRED="never"
EAPI="1"
inherit kde

DESCRIPTION="Allows *some* Gtk, Qt3, and Qt4 applications to use KDE's file dialogs when run under KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=36077"
SRC_URI="http://home.freeuk.com/cpdrummond/KGtk-${PV}.tar.bz2"
S=$WORKDIR/KGtk-$PV

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="qt4"

DEPEND=">=x11-libs/gtk+-2.6
	dev-util/cmake
	qt4? ( || ( x11-libs/qt-gui:4 x11-libs/qt:4 ) )"
need-kde 3.4

src_compile() {
	mkdir -p "${S}/build" && cd "${S}/build"
	cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=/usr \
		.. || die "cmake (configure) failed"
	emake || die "emake failed"

	if use qt4; then
		mkdir -p "${S}/build4" && cd "${S}/build4"
		cmake \
			-DCMAKE_INSTALL_PREFIX:PATH=/usr \
			-DKGTK_QT4=true -DKGTK_GTK2=false \
			.. || die "cmake (configure) failed"
		emake || die "emake failed"

	fi
}

src_install() {
	cd "${S}/build"
	emake install DESTDIR="${D}" || die "make install failed"

	if use qt4; then
		cd "${S}/build4"
		emake install DESTDIR="${D}" || die "make install failed"
	fi

	dodoc ../{AUTHORS,ChangeLog,TODO,README}
}

pkg_postinst() {
	elog "To see the kde-file-selector in a gtk-application, just do:"
	elog "cd /usr/local/bin"
	elog "ln -s /usr/bin/kgtk-wrapper application(eg. firefox)"
	elog "Make sure that /usr/local/bin is before /usr/bin in your \$PATH"
	elog
	elog "You need to restart kde and be sure to change your symlinks to non-.sh"
}
