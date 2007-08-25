# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rsstool/rsstool-1.0.0_rc2-r1.ebuild,v 1.1 2007/08/25 19:56:31 jsin Exp $

inherit versionator eutils
MY_PV=$(replace_version_separator 3 '')
MY_P=${PN}-${MY_PV}
S="${WORKDIR}/${MY_P}"-src/src
DESCRIPTION="RSStool is a tool to read, parse, merge, and write RSS (and Atom) feeds."
HOMEPAGE="http://rsstool.y7.ath.cx/"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/libxml2"
RDEPEND="dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-Makefile.patch"
}

src_compile() {
	econf
	epatch "${FILESDIR}/${P}-config.mak.patch"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" BINDIR="/usr/bin" install || die "emake install failed"
	dohtml ../*.html
}
