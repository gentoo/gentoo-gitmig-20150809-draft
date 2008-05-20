# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-1.90.0.ebuild,v 1.3 2008/05/20 19:21:37 corsair Exp $

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"
IUSE="javascript kde"

DEPEND="kde? ( || ( ( =kde-base/libkonq-3.5* =kde-base/kdebase-kioslaves-3.5* )
			=kde-base/kdebase-3.5* ) )
		javascript? ( =kde-base/kjsembed-3.5* )"

RDEPEND="${DEPEND}"

need-kde 3.5

pkg_postinst() {
	echo
	elog "For information about additional features and tools such as remote file access, packers,"
	elog "etc. you may want to use, see \"external-tools\" in /usr/share/doc/${PF}."
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

src_install() {
	kde_src_install
	dodoc "${FILESDIR}/external-tools" || die "Installing docs failed."
}
