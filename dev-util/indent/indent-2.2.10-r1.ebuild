# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/indent/indent-2.2.10-r1.ebuild,v 1.2 2009/11/23 05:16:02 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Indent program source files"
HOMEPAGE="http://www.gnu.org/software/indent/indent.html"
SRC_URI="mirror://gnu/indent/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_prepare() {
	# Fix parallel make issue in man/ (bug #76610)
	# and do not install texinfo2man
	epatch "${FILESDIR}"/${PV}-man.patch
	epatch "${FILESDIR}"/${PV}-segfault.patch
	eautoreconf
}

src_configure() {
	# LINGUAS is used in aclocal.m4 (bug #94837)
	unset LINGUAS
	econf $(use_enable nls) || die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		htmldir="/usr/share/doc/${PF}/html" \
		install || die "make install failed"
	dodoc AUTHORS NEWS README* ChangeLog*
}
