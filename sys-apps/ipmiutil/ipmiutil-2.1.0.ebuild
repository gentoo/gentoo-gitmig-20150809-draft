# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ipmiutil/ipmiutil-2.1.0.ebuild,v 1.1 2008/04/22 14:51:06 dev-zero Exp $

inherit autotools eutils

DESCRIPTION="IPMI Management Utilities"
HOMEPAGE="http://ipmiutil.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="virtual/os-headers"

src_unpack() {
	unpack ${A}
	# The following upstream directories are unneeded/obsolete:
	# hpiutil kern test
	# we remove them for safety:
	cd "${S}"
	rm -rf hpiutil kern test

	# They get misplaced
	sed -i \
		-e '/COPYING/d' \
		-e '/README/d' \
		-e '/UserGuide/d' \
		"${S}/doc/Makefile" || die "sed failed"

	epatch "${FILESDIR}/${PV}-various_compile_issues.patch"

	# Upstream requests this
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO doc/UserGuide
}
