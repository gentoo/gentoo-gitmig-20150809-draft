# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libdomainkeys/libdomainkeys-0.68-r2.ebuild,v 1.1 2010/07/10 22:12:47 hwoarang Exp $

EAPI="2"

inherit eutils

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
		${S}/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="-DBIND_8_COMPAT ${CFLAGS}" || die
}

src_install() {
	insinto /usr/lib
	doins libdomainkeys.a || die

	insinto /usr/include
	doins domainkeys.h || die
	doins dktrace.h || die

	dobin dknewkey dktest || die
	dodoc README CHANGES *.html || die

	# remove unwanted doc files
	rm -rf ${S}/testcases/CVS || die
	rm -rf ${S}/testcases/*~ || die
	docinto /testcases
	dodoc testcases/* || die
	prepalldocs || die
}
