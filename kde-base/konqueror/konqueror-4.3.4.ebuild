# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-4.3.4.ebuild,v 1.3 2010/01/20 20:47:46 abcd Exp $

EAPI="2"

KMNAME="kdebase-apps"
inherit flag-o-matic kde4-meta

DESCRIPTION="KDE: Web browser, file manager, ..."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="+bookmarks debug +handbook svg thumbnail"
# 4 of 4 tests fail. Last checked for 4.0.3
RESTRICT="test"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kfind)
	$(add_kdebase_dep kfmclient)
	bookmarks? ( $(add_kdebase_dep keditbookmarks) )
	svg? ( $(add_kdebase_dep svgpart) )
"
PDEPEND="
	thumbnail? ( $(add_kdebase_dep mplayerthumbs) )
"

KMEXTRACTONLY="
	konqueror/client/
	lib/konq/
"

src_configure() {
	mycmakeargs+=" -DWITH_KdeWebKit=OFF -DWITH_WebKitPart=OFF"

	kde4-meta_src_configure
}

src_prepare() {
	[[ ${CHOST} == *-solaris* ]] && append-ldflags -lmalloc

	kde4-meta_src_prepare

	# Do not install *.desktop files for kfmclient
	sed -e "/kfmclient\.desktop/d" -i konqueror/CMakeLists.txt \
		|| die "Failed to omit .desktop files"
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "If you want to use konqueror as a filemanager, install the dolphin kpart:"
	elog "emerge -1 kde-base/dolphin:${SLOT}"
	elog
	elog "To use Java on webpages: emerge jre"
	echo
}
