# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sloccount/sloccount-2.26-r2.ebuild,v 1.1 2010/10/12 20:52:02 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Tools for counting Source Lines of Code (SLOC) for a large number of languages"
HOMEPAGE="http://www.dwheeler.com/sloccount/"
SRC_URI="http://www.dwheeler.com/sloccount/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""
RDEPEND="dev-lang/perl
		>=sys-apps/sed-4
		app-shells/bash"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libexec.patch
	epatch "${FILESDIR}"/${P}-coreutils-tail-n-fix.patch

	sed -i \
		-e 's|^CC=gcc|CFLAGS+=|g' \
		-e 's|$(CC)|& $(CFLAGS) $(LDFLAGS)|g' \
		-e '/^DOC_DIR/ { s/-$(RPM_VERSION)//g }' \
		-e '/^MYDOCS/ { s/[^    =]\+\.html//g }' \
		makefile || die "sed makefile failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	einstall PREFIX="${D}/usr" DOC_DIR="${D}/usr/share/doc/${PF}/" || die
	prepalldocs
	dohtml *html
}
