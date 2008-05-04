# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nget/nget-0.27.1.ebuild,v 1.10 2008/05/04 01:34:25 dragonheart Exp $

inherit flag-o-matic eutils

DESCRIPTION="Network utility to retrieve files from an NNTP news server"
HOMEPAGE="http://nget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

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
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch
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
