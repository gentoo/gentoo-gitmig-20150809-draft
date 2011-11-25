# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/glpk/glpk-4.47.ebuild,v 1.1 2011/11/25 19:11:22 bicatali Exp $

EAPI=4
inherit flag-o-matic

DESCRIPTION="GNU Linear Programming Kit"
LICENSE="GPL-3"
HOMEPAGE="http://www.gnu.org/software/glpk/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

SLOT="0"
IUSE="doc examples gmp odbc mysql static-libs"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~ppc-aix ~x86-fbsd ~amd64-linux ~x86-linux"

RDEPEND="odbc? ( || ( dev-db/libiodbc dev-db/unixODBC ) )
	gmp? ( dev-libs/gmp )
	mysql? ( virtual/mysql )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	local myconf="--disable-dl"
	if use mysql || use odbc; then
		myconf="--enable-dl"
	fi

	[[ -z $(type -P odbc-config) ]] && \
		append-cppflags $(pkg-config --cflags libiodbc)

	econf \
		$(use_enable mysql) \
		$(use_enable odbc) \
		$(use_enable static-libs static) \
		$(use_with gmp) \
		${myconf}
}

src_install() {
	default
	if use examples; then
		emake distclean
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
	use doc && cd "${S}"/doc && dodoc *.pdf notes/*.pdf *.txt
}
