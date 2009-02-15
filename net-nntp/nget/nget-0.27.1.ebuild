# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nget/nget-0.27.1.ebuild,v 1.11 2009/02/15 22:38:29 vapier Exp $

inherit flag-o-matic eutils

DEB_VER="10"
DEB_PATCH="${PN}_${PV}-${DEB_VER}.diff"
DESCRIPTION="Network utility to retrieve files from an NNTP news server"
HOMEPAGE="http://nget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://debian/pool/main/n/nget/${DEB_PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc sh x86"
IUSE="static debug ipv6 pcre zlib"
RESTRICT="test"

RDEPEND="dev-libs/popt
	pcre? ( dev-libs/libpcre )
	zlib? ( sys-libs/zlib )"
DEPEND="dev-libs/uulib"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/${DEB_PATCH}
	cd "${S}"
	epatch debian/patches/*.patch "${FILESDIR}"/${P}-headers.patch
	sed -i '/^install_bin/s:-s::' Makefile.in
}

src_compile() {
	use static && append-flags -static

	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with pcre) \
		$(use_with zlib) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make \
		prefix="${D}"/usr \
		mandir="${D}"/usr/share/man \
		infodir="${D}"/usr/share/info \
		install || die "install failed"

	dodoc Changelog FAQ README TODO
	newdoc .ngetrc ngetrc.sample
}
