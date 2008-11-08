# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/webfuzzer/webfuzzer-0.2.0.ebuild,v 1.3 2008/11/08 15:16:59 cedk Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Poor man's web vulnerability scanner"
HOMEPAGE="http://gunzip.altervista.org/g.php?f=projects"
SRC_URI="http://gunzip.altervista.org/webfuzzer/webfuzzer-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/devel

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/CFLAGS=-g -O3/CFLAGS+=-g/" \
		-e "s/CC=/CC?=/" \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dodoc CHANGES README TODO
	dobin webfuzzer
}
