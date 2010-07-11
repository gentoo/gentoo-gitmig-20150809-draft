# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kyotocabinet/kyotocabinet-1.0.4.ebuild,v 1.1 2010/07/11 11:27:52 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A straightforward implementation of DBM"
HOMEPAGE="http://1978th.net/kyotocabinet/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris"
IUSE="debug doc examples"

DEPEND="sys-libs/zlib
	app-arch/bzip2"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/fix_rpath.patch"
	epatch "${FILESDIR}/remove_ldconfig-${PV}.patch"
	epatch "${FILESDIR}/remove_docinst.patch"
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	if use examples; then
		insinto /usr/share/doc/${P}/example
		doins example/* || die "Install failed"
	fi

	if use doc; then
		insinto /usr/share/doc/${P}
		doins -r doc/* || die "Install failed"
	fi
}

src_test() {
	emake -j1 check || die "Tests failed"
}
