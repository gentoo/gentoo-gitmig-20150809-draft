# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libdomainkeys/libdomainkeys-0.69.ebuild,v 1.1 2011/06/10 11:13:25 eras Exp $

EAPI=4

inherit eutils multilib

DESCRIPTION="libdomainkeys is a library usable by MTAs to verify and create signatures of e-mail headers."
HOMEPAGE="http://domainkeys.sourceforge.net/"
SRC_URI="mirror://sourceforge/domainkeys/${P}.tar.gz"

# Licensed under the Yahoo! DomainKeys Public License Agreement v1.1
LICENSE="libdomainkeys-1.1"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-devel/libtool-1.4.1-r8
		dev-libs/openssl"
RDEPEND=""

src_prepare() {
	# fix libs, dump hardcoded vars to respect CC (bug #244142) and CFLAGS (bug #240782)
	sed -i -e 's:-lcrypto:-lcrypto -lresolv:' \
		-e 's:^CC=:#CC=:' -e 's:^CFLAGS=:#CFLAGS=:' \
		-e "s:\$(CFLAGS):\$(CFLAGS) \$(LDFLAGS):g" \
		"${S}"/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="-DBIND_8_COMPAT ${CFLAGS}"
}

src_install() {
	insinto /usr/$(get_libdir)
	doins libdomainkeys.a

	insinto /usr/include
	doins domainkeys.h
	doins dktrace.h

	dobin dknewkey dktest
	dodoc README CHANGES *.html

	# remove unwanted doc files
	rm -rf "${S}"/testcases/CVS
	rm -rf "${S}"/testcases/*~
	docinto /testcases
	dodoc testcases/*
}
