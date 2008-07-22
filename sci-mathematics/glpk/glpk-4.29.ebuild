# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/glpk/glpk-4.29.ebuild,v 1.1 2008/07/22 22:07:15 bicatali Exp $

DESCRIPTION="GNU Linear Programming Kit"
LICENSE="GPL-3"
HOMEPAGE="http://www.gnu.org/software/glpk/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

SLOT="0"
IUSE="doc examples gmp iodbc mysql"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

DEPEND="iodbc? ( dev-db/libiodbc )
	gmp? ( dev-libs/gmp )
	mysql? ( virtual/mysql )"

src_compile() {
	local myconf="--disable-dl"
	if use mysql || use iodbc; then
		myconf="--enable-dl"
	fi
	econf \
		--with-zlib \
		$(use_with gmp) \
		$(use_enable iodbc odbc) \
		$(use_enable mysql) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# INSTALL include some usage docs
	dodoc AUTHORS ChangeLog NEWS README || \
		die "failed to install docs"

	insinto /usr/share/doc/${PF}
	if use examples; then
		emake distclean
		doins -r examples || die "failed to install examples"
	fi
	if use doc; then
		cd "${S}"/doc
		doins memo/gomory.djvu || die "failed to instal memo"
		dodoc *.ps *.txt || die "failed to install manual files"
	fi
}
