# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libofx/libofx-0.9.0.ebuild,v 1.6 2008/05/05 22:29:47 eva Exp $

EAPI="1"

inherit eutils

DESCRIPTION="Library to support the Open Financial eXchange XML Format"
HOMEPAGE="http://libofx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=app-text/opensp-1.5
	 >=net-misc/curl-7.9.7
	dev-cpp/libxmlpp:0
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	# because we redefine docdir in src_install, we need to make sure the
	# dtd's go to the right place, LIBOFX_DTD_DIR
	sed -i \
		-e 's/$(DESTDIR)$(docdir)/$(DESTDIR)$(LIBOFX_DTD_DIR)/g' \
		"${S}/dtd/Makefile.in" || die "sed failed"

	# We don't want those files
	sed -i \
		-e '/^  COPYING/d' -e '/^  INSTALL/d' \
		"${S}/Makefile.in" || die "sed failed"

	if ! use doc; then
		sed -i \
			-e 's|^\(SUBDIRS = .*\) doc|\1|' \
			"${S}/Makefile.in" || die "sed failed"
	fi

	# Fix compilation with gcc 4.3, see bug #218782
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_install() {
	dodir /usr/share/doc/${PF}
	emake install DESTDIR="${D}" docdir="/usr/share/doc/${PF}" || die 'install failed'
}

pkg_postinst() {
	elog "Please run"
	elog "  revdep-rebuild --library libofx.so.3"
	elog "to rebuild packages linked against an older version of libofx."
}
