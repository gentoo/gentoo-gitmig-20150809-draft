# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-1.70.1.ebuild,v 1.11 2007/01/05 17:03:03 flameeyes Exp $

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="javascript kde"

DEPEND="kde? ( || ( ( kde-base/libkonq kde-base/kdebase-kioslaves )
			kde-base/kdebase ) )
	!sparc? ( javascript? ( kde-base/kjsembed ) )"

RDEPEND="${DEPEND}"

need-kde 3.4

pkg_postinst() {
	echo
	elog "Krusader can use various external applications, including:"
	elog "- KMail	 (kde-base/kdepim)"
	elog "- Kompare (kde-base/kdesdk)"
	elog "- KDiff3	 (kde-misc/kdiff3)"
	elog "- XXdiff	 (dev-util/xxdiff)"
	elog "- KRename (kde-misc/krename)"
	elog "- Eject	 (virtual/eject)"
	elog ""
	elog "It supports also quite a few archive formats, including:"
	elog "- app-arch/arj"
	elog "- app-arch/unarj"
	elog "- app-arch/rar"
	elog "- app-arch/zip"
	elog "- app-arch/unzip"
	elog "- app-arch/unace"
	echo
	ewarn "IMPORTANT: Please remove your ~/.kde/share/apps/krusader/krusaderui.rc file"
	ewarn "after installation!!! (Else you won't see new menu entries. But please note:"
	ewarn "This will also reset all your changes on toolbars and shortcuts!)"
	echo
}

src_unpack() {
	# Don't use kde_src_unpack or the new admindir updating code
	# will reset admindir before the configure.in.bot change is fixed.
	unpack ${A}

	# Stupid thing to do, but upstream did it
	mv "${S}/admin/configure.in.bot.end" "${S}/configure.in.bot"

	rm -rf "${S}/admin" "${S}/configure"
	ln -s "${WORKDIR}/admin" "${S}/admin"
}

src_compile() {
	local myconf="$(use_with kde konqueror) $(use_with javascript) --with-kiotar"
	kde_src_compile
}
