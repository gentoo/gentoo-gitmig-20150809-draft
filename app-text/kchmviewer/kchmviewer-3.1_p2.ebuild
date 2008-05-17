# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kchmviewer/kchmviewer-3.1_p2.ebuild,v 1.2 2008/05/17 12:31:48 pva Exp $

inherit autotools kde-functions eutils versionator

MY_P="${PN}-$(replace_version_separator 2 '-')"
MY_P="${MY_P/p}"

DESCRIPTION="KchmViewer is a feature rich chm file viewer, based on Qt."
HOMEPAGE="http://www.kchmviewer.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="arts kde"

DEPEND="=x11-libs/qt-3*
	dev-libs/chmlib
	kde? ( =kde-base/kdelibs-3.5* )"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-2)"

pkg_setup() {
	if use kde; then
		if use arts && ! built_with_use =kde-base/kdelibs-3.5* arts ; then
			eerror "You are trying to compile ${CATEGORY}/${PF} with the \"arts\" USE flag enabled."
			eerror "However, $(best_version =kde-base/kdelibs-3.5*) was compiled with this flag disabled."
			eerror
			eerror "You must either disable this use flag, or recompile"
			eerror "$(best_version kde-base/kdelibs) with this use flag enabled."
			die "Impossible to build kde package with different from kdelibs arts setting"
		elif ! use arts && built_with_use =kde-base/kdelibs-3.5* arts ; then
			eerror "You are trying to compile ${CATEGORY}/${PF} with the \"arts\" USE flag disabled."
			eerror "However, $(best_version =kde-base/kdelibs-3.5*) was compiled with this flag enabled."
			eerror
			eerror "You must either enable this use flag, or recompile"
			eerror "$(best_version =kde-base/kdelibs-3.5*) with this use flag disabled."
			die "Impossible to build kde package with different from kdelibs arts setting"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# gcc 4.3 compatibility. Fixes bug 218812.
	epatch "${FILESDIR}/${P}-gcc43.patch"

	# broken configure script, assure it doesn't fall back to internal libs
	echo "# We use the external chmlib!" > lib/chmlib/chm_lib.h
}

src_compile() {
	set-kdedir 3

	econf $(use_with kde) $(use_with arts) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	dodoc ChangeLog FAQ DCOP-bingings README || die "installing docs failed"
}
