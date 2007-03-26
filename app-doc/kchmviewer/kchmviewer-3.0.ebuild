# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/kchmviewer/kchmviewer-3.0.ebuild,v 1.4 2007/03/26 08:53:31 pva Exp $

inherit autotools kde-functions eutils

DESCRIPTION="KchmViewer is a feature rich chm file viewer, based on Qt."
HOMEPAGE="http://kchmviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${P}.tar.gz
		mirror://gentoo/${P}-admin-dir.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arts kde"

DEPEND="=x11-libs/qt-3*
	app-doc/chmlib
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

src_unpack() {
	unpack ${A}
	cd "${S}"
	# broken configure script, assure it doesn't fall back to internal libs
	echo "# We use the external chmlib!" > lib/chmlib/chm_lib.h

	rm -rf admin && mv ../admin .
	sed -i -e \
	"s:{datadir}/applnk:{datadir}/applications:" admin/acinclude.m4.in
	# Apply patch for broken paths only when without kde. See bug #129225.
	epatch "${FILESDIR}"/${P}-qt-only-path-fix.diff
	epatch "${FILESDIR}"/${P}-fix-as-needed.diff
	make -f admin/Makefile.common
}

src_compile() {
	set-kdedir 3

	econf $(use_with kde) $(use_with arts) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog FAQ DCOP-bingings README
}
