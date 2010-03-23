# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/indent/indent-2.2.11.ebuild,v 1.1 2010/03/23 03:50:45 jer Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Indent program source files"
HOMEPAGE="http://indent.isidore-it.eu/beautify.html"
SRC_URI="http://${PN}.isidore-it.eu/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-segfault.patch
}

src_configure() {
	# LINGUAS is used in aclocal.m4 (bug #94837)
	unset LINGUAS
	econf $(use_enable nls) || die "configure failed"
}

src_test() {
	emake -C regression/ || die "regression tests failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		htmldir="/usr/share/doc/${PF}/html" \
		install || die "make install failed"
	dodoc AUTHORS NEWS README* ChangeLog*
}
