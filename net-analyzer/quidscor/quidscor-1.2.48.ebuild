# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/quidscor/quidscor-1.2.48.ebuild,v 1.2 2004/03/29 01:07:03 vapier Exp $

DESCRIPTION="IDS/VA Correlation engine"
HOMEPAGE="http://quidscor.sourceforge.net/"
SRC_URI="mirror://sourceforge/quidscor/${P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-libs/libxml2-2.4
	>=net-misc/curl-7.10
	>=net-analyzer/snort-2.0"

src_unpack() {
	unpack ${A}
	sed -i '/^CFLAGS=/s: -g : :' Makefile
}

src_compile() {
	emake EXTRA_CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake PREFIX=/usr STAGING_PREFIX=${D} install || die
	dodoc ChangeLog FAQ MANIFEST README TODO
	# fix ugly install
	cd ${D}/usr
	mv etc ..
	rm -rf doc
}
