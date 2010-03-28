# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tokyodystopia/tokyodystopia-0.9.14.ebuild,v 1.1 2010/03/28 12:36:37 patrick Exp $

EAPI=2

inherit eutils

DESCRIPTION="A fulltext search engine for Tokyo Cabinet"
HOMEPAGE="http://1978th.net/tokyodystopia/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#dev-db/tokyocabinet for depend?
DEPEND="dev-db/tokyocabinet"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup tyrant
	enewuser tyrant -1 -1 /var/lib/${PN} tyrant
}

src_prepare() {
	epatch "${FILESDIR}/fix_rpath.patch"
	epatch "${FILESDIR}/fix_ldconfig.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	for x in /var/{lib,run,log}/${PN}; do
		dodir "${x}" || die "Install failed"
		fowners tyrant:tyrant "${x}"
	done

}

src_test() {
	emake -j1 check || die "Tests failed"
}
