# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/kchmviewer/kchmviewer-1.0.ebuild,v 1.2 2005/08/11 01:03:25 metalgod Exp $

inherit kde-functions eutils

DESCRIPTION="Qt-based feature rich CHM file viewer."
HOMEPAGE="http://kchmviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arts kde"

DEPEND="=x11-libs/qt-3*
	kde? ( kde-base/kdelibs )"

pkg_setup() {
	if use kde && use arts && ! built_with_use kde-base/kdelibs arts ; then
		eerror "You are trying to compile ${CATEGORY}/${PF} with the \"arts\" USE flag enabled."
		eerror "However, $(best_version kde-base/kdelibs) was compiled with this flag disabled."
		eerror
		eerror "You must either disable this use flag, or recompile"
		eerror "$(best_version kde-base/kdelibs) with this use flag enabled."
		die
	fi
}

src_compile() {
	set-kdedir 3

	econf $(use_with kde) $(use_with arts) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog
}
