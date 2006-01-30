# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/re2c/re2c-0.9.1.ebuild,v 1.7 2006/01/30 13:22:24 blubb Exp $

inherit eutils

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://www.tildeslash.org/re2c/"
SRC_URI="http://www.tildeslash.org/re2c/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-util/byacc-1.9
	!>=sys-devel/gcc-3.3.2"

src_unpack() {
	unpack ${A} || die
	# Fix permissions
	chmod -R u+rw ${S}
	epatch ${FILESDIR}/${PV}-patch
}

src_compile() {
	emake -e || die
}

src_install() {
	dobin re2c || die "dobin failed"
	doman re2c.1
	dodoc CHANGELOG NO_WARRANTY README doc/*
}
