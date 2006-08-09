# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.5.4.ebuild,v 1.1 2006/08/09 13:50:39 carlo Exp $

inherit db-use kde-dist

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."

KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="berkdb subversion"

DEPEND="x86? ( || ( >=dev-util/valgrind-3.2.0
					dev-util/callgrind ) )
	subversion? ( dev-util/subversion )
	berkdb? ( =sys-libs/db-4* )"

RDEPEND="${DEPEND}
	dev-util/cvs
	media-gfx/graphviz"

DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {
	local myconf="$(use_with subversion)"

	if use berkdb; then
                myconf="${myconf} --with-berkeley-db --with-db-lib="$(db_libname)"
			--with-extra-includes=${ROOT}$(db_includedir)"
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	kde_src_compile
}
