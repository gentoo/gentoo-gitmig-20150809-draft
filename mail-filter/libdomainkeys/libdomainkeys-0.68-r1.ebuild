# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libdomainkeys/libdomainkeys-0.68-r1.ebuild,v 1.8 2007/06/17 07:13:30 dertobi123 Exp $

inherit eutils

DESCRIPTION="libdomainkeys is a library usable by MTAs to verify and create signatures of e-mail headers."
HOMEPAGE="http://domainkeys.sourceforge.net/"
SRC_URI="mirror://sourceforge/domainkeys/${P}.tar.gz"

# Licensed under the Yahoo! DomainKeys Public License Agreement v1.1
LICENSE="libdomainkeys-1.1"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND=">=sys-devel/libtool-1.4.1-r8
		dev-libs/openssl"
RDEPEND=""

src_unpack() {
	unpack ${A}
	sed -i -e "s:-lcrypto:-lcrypto -lresolv:" ${S}/Makefile
}

src_install() {
	insinto /usr/lib
	doins libdomainkeys.a

	insinto /usr/include
	doins domainkeys.h
	doins dktrace.h

	dobin dknewkey dktest
	dodoc README CHANGES *.html

	# remove unwanted doc files
	rm -rf ${S}/testcases/CVS
	rm -rf ${S}/testcases/*~
	docinto /testcases
	dodoc testcases/*
	prepalldocs
}

